
nosso_numero = '002371701661'

tampart1 = len(nosso_numero) // 2
tampar2 = len(nosso_numero) % 2
base = 7
dv = int()
for x in nosso_numero[0:tampart1]:
    if base == 1:
        base = 7
    
    dv += int(x) * base
    base -= 1
    print(f'Valor Dig verificador: {dv} -- Valor Base: {base}')

print('----')
base = 7
for y in nosso_numero[tampart1:]:
    
    if base == 1:
        base = 7
    dv += int(y) * base
    base -= 1
    print(f'Valor Dig verificador: {dv} -- Valor Base: {base}')
if dv % 11 == 1:
    print('P')
else:
    print(dv % 11)