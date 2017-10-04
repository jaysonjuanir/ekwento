import com.mmm.ekwento.UserAccount
import com.mmm.ekwento.UserRole
import com.mmm.ekwento.UserGroup
import com.mmm.ekwento.UserGroupUserRole
import com.mmm.ekwento.UserAccountUserGroup

class BootStrap {
    
    def springSecurityService

    def init = { servletContext ->
        
        def searchAdminAccount = UserAccount.findByUsername('ekwento')
        def searchAdminGroup = UserGroup.findByName("GROUP_ADMIN")
        def searchAdminRole = UserRole.findByAuthority("ROLE_ADMIN_DASHBOARD")
        if(!searchAdminAccount){
            def user = new UserAccount()
            user.username = 'ekwento'
            user.password = springSecurityService.encodePassword('ekwento')
            user.save(flush:true)
        }else{
            println("Already have admin account!")
        }
        if(!searchAdminGroup){
            def group = new UserGroup()
            group.name = 'GROUP_ADMIN'
            group.save(flush:true)
        }
        if(!searchAdminRole){
            def role = new UserRole()
            role.authority = 'ROLE_ADMIN_DASHBOARD'
            role.save(flush:true)
        }
        
        if(!searchAdminGroup && !searchAdminRole){
            UserGroupUserRole.create(group, role, true)
        }
        
        if(!searchAdminAccount && !searchAdminGroup){
            UserAccountUserGroup.create(user,group,true)
        }
        
        println("Initialize eKwento!")
    }
    def destroy = {
    }
}
