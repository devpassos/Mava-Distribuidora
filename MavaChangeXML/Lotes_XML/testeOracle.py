import cx_Oracle

cx_Oracle.init_oracle_client(config_dir=r"LD_LIBRARY_PATH")

# Connect as user "hr" with password "welcome" to the "orclpdb1" service running on this computer.
connection = cx_Oracle.connect("system", "Manager95sen99", "192.168.0.2/WINT")

cursor = connection.cursor()
cursor.execute("""
        SELECT codprod, descricao
        FROM pcprodut
        WHERE codepto = :did""",
        did = 3)

for codprod, descricao in cursor:
    print("Values:", codprod, descricao)