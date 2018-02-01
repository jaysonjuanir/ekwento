package com.mmm.ekwento

import groovy.sql.Sql;
import grails.transaction.Transactional

@Transactional
class SearchService {
	def dataSource

    def getGlobalLatestUploadResult(int offset, int limit) {
		def latestGlobalUploadResultList = []
		if(offset!=0) offset++
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, id, title, description, logo, rejected, number_of_views as numberOfViews, date_created as dateCreated from book where rejected = 0
union 
select 'article' as type, id, title, description, logo, rejected, number_of_views as numberOfViews, date_created as dateCreated from article where rejected = 0
union 
select 'manga' as type, id, title, description, logo, rejected, number_of_views as numberOfViews, date_created as dateCreated from manga where rejected = 0 order by dateCreated desc;
"""
		
		def sqlData = sql.rows(query, offset, limit)
	
		if(sqlData){
			sqlData.each{latest->
				def map = [:]
				map.type = latest.type
				map.id = latest.id
				map.title = latest.title
				map.description = latest.description
				map.numberOfViews = latest.numberOfViews
				map.dateCreated = latest.dateCreated
				map.logo = latest.logo?true:false 
				
				latestGlobalUploadResultList.add(map)
			}
		}
		
		
		sql.close()
			
		return latestGlobalUploadResultList
    }
	
	def getGlobalLatestUploadCount() {
		def latestGlobalUploadCount = 0
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, id, count(*) as count, rejected, date_created as dateCreated from book where rejected = 0
union 
select 'article' as type, id, count(*) as count, rejected, date_created as dateCreated from article where rejected = 0
union 
select 'manga' as type, id, count(*) as count, rejected, date_created as dateCreated from manga where rejected = 0 order by dateCreated desc;
"""
		
		def sqlData = sql.rows(query)
	
		if(sqlData){
			sqlData.each{latest->
				latestGlobalUploadCount += latest.count
			}
		}
		
		
		sql.close()
			
		return latestGlobalUploadCount
    }
	
	def getGlobalPopularUploadResult(int offset, int limit) {
		def popularGlobalUploadResultList = []
		if(offset!=0) offset++
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from book where rejected = 0
union 
select 'article' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from article where rejected = 0
union 
select 'manga' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from manga where rejected = 0 order by numberOfViews desc;
"""
		def sqlData = sql.rows(query, offset, limit)
		if(sqlData){
			sqlData.each{popular->
				def map = [:]
				map.type = popular.type
				map.id = popular.id
				map.title = popular.title
				map.description = popular.description
				map.dateCreated = popular.dateCreated
				map.numberOfViews = popular.numberOfViews
				map.logo = popular.logo?true:false
				
				popularGlobalUploadResultList.add(map)
			}
		}
		
		sql.close()
			
		return popularGlobalUploadResultList
    }
	
	def getGlobalPopularUploadCount() {
		def popularGlobalUploadCount = 0
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, count(*) as count, rejected, number_of_views as numberOfViews from book where rejected = 0
union 
select 'article' as type, count(*) as count, rejected, number_of_views as numberOfViews from article where rejected = 0
union 
select 'manga' as type, count(*) as count, rejected, number_of_views as numberOfViews from manga where rejected = 0 order by numberOfViews desc;
"""
		
		def sqlData = sql.rows(query)
	
		if(sqlData){
			sqlData.each{popular->
				popularGlobalUploadCount += popular.count
			}
		}
		
		
		sql.close()
			
		return popularGlobalUploadCount
    }
	
	def searchGlobalResult(String search, int offset, int limit){
		def searchGlobalUploadResultList = []
		def searchCriteria = "%"+search+"%"
		if(offset!=0) offset++
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from book where title like ? and rejected = 0
union 
select 'article' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from article where title like ? and rejected = 0
union 
select 'manga' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from manga where title like ? and rejected = 0 order by title desc;
"""
		def searchParams = [searchCriteria, searchCriteria, searchCriteria]
		def sqlData = sql.rows(query, searchParams, offset, limit)
		if(sqlData){
			sqlData.each{ searchGlobal ->
				def map = [:]
				map.type = searchGlobal.type
				map.id = searchGlobal.id
				map.title = searchGlobal.title
				map.description = searchGlobal.description
				map.logo = searchGlobal.logo?true:false

				searchGlobalUploadResultList.add(map)
			}
		}
		
		sql.close()
			
		return searchGlobalUploadResultList
	}
	
	def searchGlobalCount(String search){
		def searchCountSum = 0
		def searchCriteria = "%"+search+"%"
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, count(*) as count, title, rejected from book where title like ? and rejected = 0
union 
select 'article' as type, count(*) as count, title, rejected from article where title like ? and rejected = 0
union 
select 'manga' as type, count(*) as count, title, rejected from manga where title like ? and rejected = 0 order by title desc;
"""
		def searchParams = [searchCriteria, searchCriteria, searchCriteria]
		def sqlData = sql.rows(query, searchParams)
		if(sqlData){
			sqlData.each{ searchCount ->
				searchCountSum += searchCount.count
			}
		}
		
		sql.close()
			
		return searchCountSum
	}
}
