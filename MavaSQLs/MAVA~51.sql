select codcli, cliente, receberboletoporemail from pcclient where codusur1 not in (13, 14, 15, 16) and receberboletoporemail = 'N'

order by cliente