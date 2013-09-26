// # Ghost Configuration
// Setup your Ghost install for various environments

var path = require('path'),
    config;

config = {
    production: {
        url: 'http://$fqdn',
        mail: {
            transport: 'sendmail',
            path: '/usr/sbin/sendmail',
            from: "ghost@$fqdn",
        },
        database: {
            client: 'mysql',
            connection: {
                host     : 'localhost',
                user     : 'root',
                password : '$mysql_password',
                database : 'ghost_production',
                charset  : 'utf8'
            },
            debug: false
        },
        server: {
            host: '0.0.0.0',
            port: '2368'
        }
    }
};

// Export config
module.exports = config;