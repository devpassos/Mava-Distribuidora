SELECT ((BASE.DBID + USUARIO.USER_ID) * 3) IDENTIFICADOR, NVL(PCCONSUM.CODCLIPC,0) AS CODCLIPC
FROM V$DATABASE BASE, TESTE.PCCONSUM,(SELECT USERNAME, USER_ID FROM ALL_USERS) USUARIO
WHERE UPPER(USUARIO.USERNAME) = 'TESTE';