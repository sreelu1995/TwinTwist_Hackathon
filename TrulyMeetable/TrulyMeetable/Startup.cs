using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TrulyMeetable.Startup))]
namespace TrulyMeetable
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
