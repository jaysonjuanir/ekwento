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
        def user
        def group
        def role
        if(!searchAdminAccount){
            
            user = new UserAccount()
            user.username = 'ekwento'
            user.firstName = 'ekwento'
            user.lastName = 'ekwento'
            user.email = 'ekw3nt0@gmail.com'
            user.token = '1'
            user.password = springSecurityService.encodePassword('ekwento')
            user.save(flush:true, failOnError:true)
            println("User Account Created!")
        }else{
            println("Already have admin account!")
        }
        if(!searchAdminGroup){
            group = new UserGroup()
            group.name = 'GROUP_ADMIN'
            group.save(flush:true, failOnError:true)
            println("User Group Created!")
        }
        if(!searchAdminRole){
            role = new UserRole()
            role.authority = 'ROLE_ADMIN_DASHBOARD'
            role.save(flush:true, failOnError:true)
            println("User Role Created!")
        }
        
        if(!searchAdminGroup && !searchAdminRole){
            UserGroupUserRole.create(group, role, true)
            println("User Group User Role Created!")
        }
        
        if(!searchAdminAccount && !searchAdminGroup){
            UserAccountUserGroup.create(user,group,true)
            println("User Account User Group Created!")
        }
        
        println("Initialize eKwento!")
    }
    def destroy = {
    }
}
