// fifo.js

var oracledb = require('oracledb');

oracledb.getConnection({
    user: "USUARIO DE CONEXÃO COM BANCO",
    password: "PASSWORD",
    connectString: "localhost/xe"
},  function(err, connection) {
    if (err) {
        console.error(err.message);
    return;
    
}
connection.execute( "SELECT campo_tabela FROM oracle WHERE oracledb like 'andersoncaldeira'",
[],
function(err, result) {
    if (err) {
        console.error(err.message);
        doRelease(connection);
        return;
    }
        
        console.log(result.metaData);
        console.log(result.rows);
        doRelease(connection);
    });
});
function doRelease(connection) {
    connection.release(
        function(err) {
            if (err) {console.error(err.message);}
        }
    );
}