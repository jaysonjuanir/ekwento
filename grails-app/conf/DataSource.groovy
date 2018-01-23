dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = "root"
    dialect = 'org.hibernate.dialect.MySQL5InnoDBDialect'
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    //    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/ekwento1"
        }
    }
    test {
        dataSource {
            username = "ekwentoc_admin"
			password = "3kw3nt0"
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://173.243.120.231/ekwentoc_prod"
        }
    }
    production {
        dataSource {
			username = "ekwentoc_admin"
			password = "3kw3nt0"
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://173.243.120.231/ekwentoc_prod"
        }
    }
}
