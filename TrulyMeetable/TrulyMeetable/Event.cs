//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TrulyMeetable
{
    using System;
    using System.Collections.Generic;
    
    public partial class Event
    {
        public int EventId { get; set; }
        public string EventName { get; set; }
        public string Location { get; set; }
        public Nullable<System.DateTime> DateTime { get; set; }
        public string Topic { get; set; }
        public string Description { get; set; }
        public string Contacts { get; set; }
        public Nullable<int> Likes { get; set; }
    }
}
