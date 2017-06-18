SET DEFINE OFF;

CREATE TABLE appl_user(
  user_id VARCHAR2(18 ) NOT NULL,
  frst_nm VARCHAR2(100 ) NOT NULL,
  mid_nm VARCHAR2(100 ),
  lst_nm VARCHAR2(100 ),
  phne_num VARCHAR2(50 ),
  email_txt VARCHAR2(100 ),
  actv_ind VARCHAR2(1 ) DEFAULT 'Y' NOT NULL,
  crte_by_id VARCHAR2(18 ) DEFAULT sys_context('USERENV', 'OS_USER') NOT NULL,
  crte_on_dt DATE DEFAULT SYSDATE NOT NULL,
  updt_by_id VARCHAR2(18 ),
  updt_on_dt DATE,
  CONSTRAINT chk_actv_ind04 CHECK (upper (actv_ind) IN ('Y', 'N'))
)
/

-- Add keys for table IFREE_ADMIN.APPL_USER

ALTER TABLE appl_user ADD CONSTRAINT appl_user_pk PRIMARY KEY (user_id)
/

ALTER TABLE appl_user ADD (password_encrypted VARCHAR2(1000));

CREATE INDEX appl_user_frst_nm_ix ON appl_user (frst_nm)
/

CREATE INDEX appl_user_lst_nm_ix ON appl_user (lst_nm)
/

CREATE SEQUENCE appl_user_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999;
-- Table and Columns comments section
  
COMMENT ON TABLE appl_user IS 'Holds all the information of Users accessing the Application.';
COMMENT ON COLUMN appl_user.user_id IS 'The user id ';
COMMENT ON COLUMN appl_user.frst_nm IS 'First name of the user. Is a search field.';
COMMENT ON COLUMN appl_user.mid_nm IS 'The middle name of users. Is not a search field';
COMMENT ON COLUMN appl_user.lst_nm IS 'Last name of the user. Is a search field.';
COMMENT ON COLUMN appl_user.phne_num IS 'The primary contact number of the user.';
COMMENT ON COLUMN appl_user.email_txt IS 'The email id of the user. Is a search field.';
COMMENT ON COLUMN appl_user.actv_ind IS 'To indicate whether a record is soft deleted or not. ''Y'' means the record is soft deleted, hence cannot be used or viewed any longer. Used for maintaining data history. Default value is ''Y'', means the record is currently active.';
COMMENT ON COLUMN appl_user.crte_by_id IS 'Identifies the person or system who created this record. Example: E502086';
COMMENT ON COLUMN appl_user.crte_on_dt IS 'The date that this record was created. Example: 12/04/06';
COMMENT ON COLUMN appl_user.updt_by_id IS 'Identifies the person or system who last updated this record. Example: E502086';
COMMENT ON COLUMN appl_user.updt_on_dt IS 'The date that this record was last updated. Example: 12/04/06';

CREATE TABLE topic(topic_id NUMBER, topic_nm VARCHAR2(100), topic_desc VARCHAR2(1000), actv_ind VARCHAR2(1));

ALTER TABLE topic ADD CONSTRAINT topic_pk PRIMARY KEY (topic_id);

CREATE TABLE user_topic(user_id VARCHAR2(18), topic_id NUMBER);

ALTER TABLE user_topic ADD CONSTRAINT user_topic_pk PRIMARY KEY (user_id, topic_id);

CREATE TABLE user_tweet(user_id VARCHAR2(18), tweet_txt VARCHAR2(4000));

CREATE SEQUENCE topic_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999;

--  INSERT INTO topic VALUES(1,'Oracle', NULL, 'Y');
--  INSERT INTO topic VALUES(2,'Microsoft', NULL, 'Y');
--  INSERT INTO topic VALUES(3,'Samsung', NULL, 'Y');
--  INSERT INTO topic VALUES(4,'Data Science', NULL, 'Y');
--  INSERT INTO topic VALUES(5,'Database', NULL, 'Y');
--  
--  INSERT INTO appl_user(user_id, frst_nm) VALUES (1, 'Shree');
--  INSERT INTO appl_user(user_id, frst_nm) VALUES (2, 'Evance');
--  INSERT INTO appl_user(user_id, frst_nm) VALUES (3, 'Saran');
--  INSERT INTO appl_user(user_id, frst_nm) VALUES (4, 'Chief');
--  INSERT INTO appl_user(user_id, frst_nm) VALUES (5, 'Ram');
--  INSERT INTO appl_user(user_id, frst_nm) VALUES (6, 'Dhivya');
--  
--  INSERT INTO user_topic VALUES(1,1);
--  INSERT INTO user_topic VALUES(1,2);
--  INSERT INTO user_topic VALUES(2,1);
--  INSERT INTO user_topic VALUES(3,2);
--  INSERT INTO user_topic VALUES(3,4);
--  INSERT INTO user_topic VALUES(5,1);
--  INSERT INTO user_topic VALUES(6,4);
--  
--  INSERT INTO user_tweet VALUES (1, 'I love to go the Oracle event on 31st May');
--  INSERT INTO user_tweet VALUES (1, 'I love to go the Microsoft event on 31st May');
--  INSERT INTO user_tweet VALUES (1, 'I love to go the database event on 31st May');
--  
--  INSERT INTO user_tweet VALUES (2, 'I love to go the Oracle event on 31st May');
--  INSERT INTO user_tweet VALUES (3, 'I love to go the Microsoft event on 31st May');
--  INSERT INTO user_tweet VALUES (4, 'I love to go the database event on 31st May');
--  INSERT INTO user_tweet VALUES (4, 'Seems like an microsoft event is coming up');
--  INSERT INTO user_tweet VALUES (6, 'oracle');

CREATE TABLE activity (activity_id NUMBER, activity_nm VARCHAR2(255), activity_desc VARCHAR2(1000));

CREATE TABLE user_activity(user_id VARCHAR2(18), activity_id NUMBER, activity_nm VARCHAR2(255), activity_desc VARCHAR2(1000), topic_id NUMBER);

ALTER TABLE user_activity ADD (activity_typ_ind VARCHAR2(100));

--INSERT INTO user_activity VALUES ('1', 1, 'Oracle Workshop', 'Oracle Workshop on Sep 17th 2017', 1);

CREATE SEQUENCE user_activity_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999; 

--SELECT * FROM user_activity;
/*table track users who get shared activity by a specific user*/
CREATE SEQUENCE user_shared_activity_seq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999; 

CREATE TABLE user_shared_activity(id NUMBER, shared_user_id VARCHAR2(18), shared_activity_id NUMBER, notified_user_id VARCHAR2(18), dismiss_ind VARCHAR2(1));

create or replace PACKAGE tweet_pkg 
IS
    /* create an user during Registration */
    PROCEDURE create_user(
        pi_user_name IN VARCHAR2,
        pi_password  IN VARCHAR2
    );

    /* Check if the user is valid/ password matches during login */
    FUNCTION check_user(
        pi_user_name IN VARCHAR2,
        pi_password  IN VARCHAR2
        )
    RETURN VARCHAR2;

    /*create your own topic*/ 
    PROCEDURE create_topic(
        pi_topic_nm	IN  VARCHAR2,
        pi_topic_desc	IN VARCHAR2
    );    
    /* As a user, choose the interested topics from list of topics*/ 
    PROCEDURE create_user_topic(
        pi_user_id    IN VARCHAR2,
        pi_topic_id  IN VARCHAR2
    );    
    
    /* To make ur own tweets*/
    PROCEDURE create_tweet(
        pi_user_id  IN VARCHAR2,
        pi_tweet_txt  IN VARCHAR2
    );
    
    /*Create activity for topics*/
    PROCEDURE create_activity(
        pi_user_id      IN VARCHAR2,
        pi_activity_nm  IN VARCHAR2,
        pi_activity_desc  IN VARCHAR2,
        pi_topic_id     IN VARCHAR2
    );
    
    /*retrieve activities based on users*/
    PROCEDURE get_activity(
        po_ref OUT SYS_REFCURSOR,
        pi_user_id  IN VARCHAR2,
        pi_activity_id IN VARCHAR2
        );
    
    /*create deal to share*/
    PROCEDURE create_deal(
        pi_user_id      IN VARCHAR2,
        pi_deal_nm  IN VARCHAR2,
        pi_deal_desc  IN VARCHAR2,
        pi_topic_id     IN VARCHAR2
    );
    
    /* retrieve deal */    
    PROCEDURE get_deal(
        po_ref OUT SYS_REFCURSOR,
        pi_user_id  IN VARCHAR2,
        pi_activity_id IN VARCHAR2
        );
    
    /* Get other users relevant tweet details matching the current tweet (topic within tweet) */
    PROCEDURE get_matching_tweet(
        po_ref OUT SYS_REFCURSOR,
        pi_user_id   IN VARCHAR2,
        pi_tweet_txt IN VARCHAR2);
    
    /* Find people who has similar interests/ topics */
    /* Identified using topics matching current tweet */
    /* user who have never tweeted but have liked same topic */
    /* user who have tweeted but never liked same topic */
    PROCEDURE find_people_similar_interest(
        po_ref OUT SYS_REFCURSOR, 
        pi_user_id IN VARCHAR2
        );     
    
    /* Share an activity/ deal with another specific person */
    PROCEDURE share_activity_deal_person(
        pi_user_id IN VARCHAR2,
        pi_notify_user_id IN VARCHAR2,
        pi_activity_id IN NUMBER
        );

    /* Share an activity/ deal with all person who have similar liked topics/ tweets */
    PROCEDURE share_activity_deal(
        pi_user_id IN VARCHAR2,
        pi_activity_id IN NUMBER
        );        
    
    /* When a user logs in, he should be able to dismiss the activities/ deals shared by other users to him */
    PROCEDURE dismiss_shared_activity(
        pi_shared_activity_id IN NUMBER
        );

    /* Get list of shared activities/ deals based on user */
    PROCEDURE get_shared_activity(
        po_ref  OUT  SYS_REFCURSOR,
        pi_user_id  IN VARCHAR2
        );       
END;
/

create or replace PACKAGE BODY tweet_pkg 
IS
    l_key_append  VARCHAR2(100) := '1234567890';
    
    PROCEDURE create_user(
        pi_user_name IN VARCHAR2,
        pi_password  IN VARCHAR2
    )
    IS
        l_raw           RAW(128) := UTL_RAW.cast_to_raw(pi_password);
        l_key           RAW(128) := UTL_RAW.cast_to_raw(lower(pi_user_name)||l_key_append);
        l_encryp_str    VARCHAR2(1000);
    BEGIN
    
        l_encryp_str  := DBMS_CRYPTO.encrypt(src => l_raw, 
                                         typ => DBMS_CRYPTO.des_cbc_pkcs5, 
                                         key => l_key);
                                         
        INSERT INTO appl_user (user_id, frst_nm, password_encrypted)
        VALUES (appl_user_seq.NEXTVAL, pi_user_name, l_encryp_str);
        
        COMMIT;
    END;
    
    FUNCTION check_user(
        pi_user_name IN VARCHAR2,
        pi_password  IN VARCHAR2
        )
    RETURN VARCHAR2
    IS
        l_raw           RAW(128) := UTL_RAW.cast_to_raw(pi_password);
        l_key           RAW(128) := UTL_RAW.cast_to_raw(lower(pi_user_name)||l_key_append);    
        l_encryp_str    VARCHAR2(1000);
        
        l_stored_pw     VARCHAR2(1000);
    BEGIN    
    
        SELECT password_encrypted
          INTO l_stored_pw
        FROM appl_user
        WHERE lower(frst_nm) = lower(pi_user_name);
        
        l_encryp_str  := DBMS_CRYPTO.encrypt(src => l_raw, 
                                         typ => DBMS_CRYPTO.des_cbc_pkcs5, 
                                         key => l_key);
                                         
        IF l_stored_pw = l_encryp_str
        THEN
            RETURN 'MATCH';
        ELSE
            RETURN 'NON MATCH';
        END IF;
    EXCEPTION
        WHEN no_data_found THEN
            RETURN 'INVALID USER';
    END;    
    
    PROCEDURE create_topic(
        pi_topic_nm	IN  VARCHAR2,
        pi_topic_desc	IN VARCHAR2
    )
    IS
    BEGIN
        INSERT INTO topic VALUES (topic_seq.NEXTVAL, pi_topic_nm, pi_topic_desc, 'Y');
        
        COMMIT;
    END;
        
    PROCEDURE create_user_topic(
        pi_user_id    IN VARCHAR2,
        pi_topic_id  IN VARCHAR2
    )
    IS
    BEGIN
        INSERT INTO user_topic(user_id, topic_id) VALUES(pi_user_id, pi_topic_id);
        
        COMMIT;
    END;

    PROCEDURE create_tweet(
        pi_user_id  IN VARCHAR2,
        pi_tweet_txt  IN VARCHAR2
    )
    IS
    BEGIN
        INSERT INTO user_tweet VALUES (pi_user_id, pi_tweet_txt);
        COMMIT;
    END;

    PROCEDURE create_activity(
        pi_user_id      IN VARCHAR2,
        pi_activity_nm  IN VARCHAR2,
        pi_activity_desc  IN VARCHAR2,
        pi_topic_id     IN VARCHAR2
    )
    IS
    BEGIN
        INSERT INTO user_activity(user_id, activity_id, activity_nm, activity_desc, topic_id, activity_typ_ind) 
        VALUES (pi_user_id, user_activity_seq.NEXTVAL, pi_activity_nm, pi_activity_desc, pi_topic_id, 'ACTIVITY');
        COMMIT;
    END;

    PROCEDURE get_activity(
        po_ref OUT SYS_REFCURSOR,
        pi_user_id  IN VARCHAR2,
        pi_activity_id IN VARCHAR2
        )
    IS
    BEGIN
        OPEN po_ref 
        FOR
            SELECT * FROM user_activity
            WHERE activity_typ_ind = 'ACTIVITY'
            AND user_id = pi_user_id
            AND (activity_id = pi_activity_id OR pi_activity_id IS NULL);
            
    END;

    PROCEDURE create_deal(
        pi_user_id      IN VARCHAR2,
        pi_deal_nm  IN VARCHAR2,
        pi_deal_desc  IN VARCHAR2,
        pi_topic_id     IN VARCHAR2
    )
    IS
    BEGIN
        INSERT INTO user_activity(user_id, activity_id, activity_nm, activity_desc, topic_id, activity_typ_ind) 
        VALUES (pi_user_id, user_activity_seq.NEXTVAL, pi_deal_nm, pi_deal_desc, pi_topic_id, 'DEAL');
        COMMIT;
    END;

    PROCEDURE get_deal(
        po_ref OUT SYS_REFCURSOR,
        pi_user_id  IN VARCHAR2,
        pi_activity_id IN VARCHAR2
        )
    IS
    BEGIN
        OPEN po_ref 
        FOR
            SELECT * FROM user_activity
            WHERE activity_typ_ind = 'DEAL'
            AND user_id = pi_user_id
            AND (activity_id = pi_activity_id OR pi_activity_id IS NULL);
            
    END;
    
    PROCEDURE share_activity_deal_person(
        pi_user_id IN VARCHAR2,
        pi_notify_user_id IN VARCHAR2,
        pi_activity_id IN NUMBER
        )
    IS  
    BEGIN    
        INSERT INTO user_shared_activity(id,shared_user_id,shared_activity_id,notified_user_id,dismiss_ind)
          VALUES(user_shared_activity_seq.NEXTVAL,pi_user_id,pi_activity_id,pi_notify_user_id,'N');      
        COMMIT;              
    END;

    PROCEDURE share_activity_deal(
        pi_user_id IN VARCHAR2,
        pi_activity_id IN NUMBER
        )
    IS  
      TYPE t_rec IS RECORD (USER_ID VARCHAR2(18), USER_NAME VARCHAR2(18), TWEET_TXT  VARCHAR2(4000), TOPIC_INTERESTED  VARCHAR2(100), ORDR NUMBER);
      l_rec t_rec;
      l_activity_name user_activity.ACTIVITY_NM%TYPE;
      l_ref SYS_REFCURSOR;       
      
      l_cnt PLS_INTEGER;
    BEGIN    
      
        SELECT ACTIVITY_NM
          INTO l_activity_name
        FROM user_activity
        WHERE activity_id = pi_activity_id
        AND ROWNUM <= 1;
        
        get_matching_tweet(
              l_ref, 
              pi_user_id, 
              l_activity_name
              );
        
        LOOP
          FETCH l_ref into L_REC;
          EXIT when l_ref%NOTFOUND;          
            
            SELECT COUNT(1)
              INTO l_cnt
            FROM user_shared_activity
            WHERE shared_user_id = pi_user_id
            AND shared_activity_id = pi_activity_id
            AND notified_user_id = L_REC.user_id
            AND dismiss_ind = 'N';
            
            IF l_cnt = 0
            THEN
                INSERT INTO user_shared_activity(id,shared_user_id,shared_activity_id,notified_user_id,dismiss_ind)
                  VALUES(user_shared_activity_seq.NEXTVAL,pi_user_id,pi_activity_id,L_REC.user_id,'N');
            END IF;
        END LOOP;
        
        COMMIT;      
     END;    
  
    PROCEDURE dismiss_shared_activity(
        pi_shared_activity_id IN NUMBER
        )
    IS
    BEGIN
        UPDATE user_shared_activity
        SET dismiss_ind = 'Y'
        WHERE ID = pi_shared_activity_id;
        
        COMMIT;
    END;
    
    PROCEDURE get_shared_activity(
        po_ref  OUT  SYS_REFCURSOR,
        pi_user_id  IN VARCHAR2
        )
    IS
    BEGIN
        OPEN po_ref
        FOR
            SELECT id,
                  shared_user_id,
                  shared_activity_id,
                  notified_user_id,
                  dismiss_ind,
                  (SELECT frst_nm FROM appl_user au WHERE au.user_id = usa.shared_user_id)
                  ||' has shared activity: '
                  || (SELECT activity_nm||' - '||activity_desc FROM user_activity ua
                      WHERE ua.activity_id = usa.shared_activity_id)
                  ||' with you!!!'
            FROM user_shared_activity usa
            WHERE NOTIFIED_USER_ID = pi_user_id
            AND dismiss_ind = 'N';
    END;
    
    PROCEDURE find_people_similar_interest(
        po_ref OUT SYS_REFCURSOR, 
        pi_user_id IN VARCHAR2
        )
    IS  
    BEGIN    
        get_matching_tweet(
            po_ref, 
            pi_user_id, 
            NULL
            );
    END;    
    
    PROCEDURE get_matching_tweet(
        po_ref OUT SYS_REFCURSOR, 
        pi_user_id IN VARCHAR2, 
        pi_tweet_txt IN VARCHAR2
        )
    IS  
    BEGIN    
        OPEN po_ref
        FOR
            WITH temp AS
              (SELECT ut.user_id,
                (SELECT frst_nm FROM appl_user au WHERE au.user_id = ut.user_id
                ) user_name,
                ut.tweet_txt,
                wrd.tweet_txt_new topic_interested
              FROM user_tweet ut,
                (SELECT tweet_txt_new
                FROM
                  ( SELECT DISTINCT trim(regexp_substr(tweet_txt,'[^ ]+',1,level)) AS tweet_txt_new
                  FROM
                    (SELECT pi_tweet_txt tweet_txt
                    FROM dual
                    WHERE pi_tweet_txt IS NOT NULL -- AND pi_tweet_txt <> 'SHARE1234567890'
                  UNION ALL
                    SELECT topic_nm FROM user_topic ut, topic t
                    WHERE t.topic_id = ut.topic_id
                    AND user_id = pi_user_id
                    AND pi_tweet_txt IS NULL 
--                  UNION ALL
--                    SELECT activity_nm || activity_desc
--                    FROM user_activity
--                    WHERE user_id = pi_user_id
--                    AND pi_tweet_txt IS NOT NULL AND pi_tweet_txt = 'SHARE1234567890'
                    )
                  WHERE tweet_txt    IS NOT NULL
                    CONNECT BY level <= LENGTH( tweet_txt)-LENGTH(REPLACE(tweet_txt,' '))+1
                  ) wrd
                WHERE EXISTS 
                  (SELECT 1 FROM topic WHERE lower(topic_nm) LIKE lower(tweet_txt_new)||'%' 
                  )
                ) wrd
              WHERE lower(ut.tweet_txt) LIKE lower('%'
                ||wrd.tweet_txt_new
                ||'%')
              AND lower(ut.user_id) <> pi_user_id
              )
            SELECT *
            FROM
              ( SELECT t.*, 0 ordr FROM temp t
              UNION ALL
              SELECT ut.user_id,
                (SELECT frst_nm FROM appl_user au WHERE au.user_id = ut.user_id
                ) user_name,
                'No tweets yet, only topic match',
                t.topic_nm, 1 ordr
              FROM user_topic ut,
                topic t,
                (SELECT DISTINCT topic_interested FROM temp
                ) te
              WHERE ut.topic_id     = t.topic_id
              AND lower(t.topic_nm) = lower(te.topic_interested)
              AND ut.user_id NOT IN
                (SELECT user_id FROM temp
                )
              AND lower(ut.user_id) <> pi_user_id
              )
            ORDER BY ordr, user_id,
              lower(topic_interested);     
    END;
END;
/

--VARIABLE po_ref REFCURSOR;
--BEGIN
--  tweet_pkg.get_matching_tweet(:po_ref, '1','I will be going to oracle and micro workspace');
--END;
--/
--PRINT :po_ref;
--
--VARIABLE po_ref REFCURSOR;
--BEGIN
--  tweet_pkg.find_people_similar_interest(:po_ref, '1');
--END;
--/
--PRINT :po_ref;
--
--VARIABLE po_ref REFCURSOR;
--BEGIN
--  tweet_pkg.share_activity('1', '1');
--END;
--/
--PRINT :po_ref;
--
--DELETE FROM user_shared_activity;
--
--SELECT * FROM user_shared_activity;
--
--BEGIN
--  tweet_pkg.dismiss_shared_activity(26);
--END;
--/
--
--VARIABLE po_ref REFCURSOR;
--BEGIN
--  tweet_pkg.get_shared_activity(:po_ref, '6');
--END;
--/
--PRINT :po_ref;
--
--BEGIN
--  tweet_pkg.create_user('A', 'P@$sw0rd@11');
--END;
--/
--
--SELECT * FROM appl_user;
--
--SELECT tweet_pkg.check_user('A', 'P@$sw0rd@1') FROM dual;
--
--BEGIN
--  tweet_pkg.create_topic('test Topic', 'Topic Desc');
--END;
--/
--
--SELECT * FROM topic;