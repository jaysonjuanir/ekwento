package com.mmm.ekwento

import groovy.sql.Sql;
import grails.transaction.Transactional

@Transactional
class SearchService {
	def dataSource

    def getGlobalLatestUploadResult() {
		def latestGlobalUploadResultList = [:]
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, id, title, description, logo, rejected, date_created as dateCreated from book where rejected = 0
union 
select 'article' as type, id, title, description, logo, rejected, date_created as dateCreated from article where rejected = 0
union 
select 'manga' as type, id, title, description, logo, rejected, date_created as dateCreated from manga where rejected = 0 order by dateCreated desc LIMIT 4 OFFSET 0;
"""
		
		latestGlobalUploadResultList = sql.rows(query)
	
		
		sql.close()
			
		return latestGlobalUploadResultList
    }
	
	def getGlobalPopularUploadResult() {
		def popularGlobalUploadResultList = []
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from book where rejected = 0
union 
select 'article' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from article where rejected = 0
union 
select 'manga' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from manga where rejected = 0 order by numberOfViews desc LIMIT 8 OFFSET 0;
"""
		popularGlobalUploadResultList = sql.firstRow(query)
		
		sql.close()
			
		return popularGlobalUploadResultList
    }
	
	def searchGlobalResult(String search){
		def searchGlobalUploadResultList = []
		def searchCriteria = "%"+search+"%"
		def sql = new Sql(dataSource)
		def query = """select 'book' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from book where title like '%a%' and rejected = 0
union 
select 'article' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from article where title like '%a%' and rejected = 0
union 
select 'manga' as type, id, title, description, logo, rejected, date_created as dateCreated, number_of_views as numberOfViews from manga where title like '%a%' and rejected = 0 order by title desc LIMIT 8 OFFSET 0;
"""
		def searchTitle = [searchCriteria]
		searchGlobalUploadResultList = sql.firstRow(query, searchTitle)
		
		sql.close()
			
		return searchGlobalUploadResultList
	}
}
