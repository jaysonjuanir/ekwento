import com.mmm.ekwento.Genre
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
		def genreList = Genre.list()
        def user
        def group
        def role
		
		
		//create genre bootstrap
		if(!genreList){
			def genreDefaultList = [[type:'Science fiction',isRestricted:false],[type:'Satire',isRestricted:false],[type:'Drama',isRestricted:false], [type:'Action',isRestricted:false], [type:'Romance',isRestricted:false], [type:'Mystery',isRestricted:false],[type:'Horror',isRestricted:false], [type:'Self help',isRestricted:false], [type:'Health',isRestricted:false], [type:'Guide',isRestricted:false], [type:'Travel',isRestricted:false], [type:"Children\'s",isRestricted:false], [type:'Religion',isRestricted:false], [type:'Science',isRestricted:false], [type:'History',isRestricted:false], [type:'Math',isRestricted:false], [type:'Poetry',isRestricted:false], [type:'Encyclopedias',isRestricted:false], [type:'Dictionaries',isRestricted:false], [type:'Comics',isRestricted:false], [type:'Art',isRestricted:false], [type:'Cookbooks',isRestricted:false], [type:'Diaries',isRestricted:false], [type:'Journals',isRestricted:false], [type:'Prayer books',isRestricted:false], [type:'Series',isRestricted:false], [type:'Biographies',isRestricted:false], [type:'Fantasy',isRestricted:false], [type:'Adult',isRestricted:true], [type:'Smut',isRestricted:true], [type:'Gore',isRestricted:true], [type:'Violence',isRestricted:true]]
			
			genreDefaultList.each{ genre ->
				def genreInstance = new Genre()
				genreInstance.type = genre.type
				genreInstance.isRestricted = genre.isRestricted
				genreInstance.save(flush:true,failOnError:true)
			}
		}
		
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
