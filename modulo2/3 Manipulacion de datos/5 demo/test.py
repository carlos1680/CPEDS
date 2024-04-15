# Laboratorio de extracción de datos de HTML

import pandas as pd 

lista_tablas = pd.read_html("https://en.wikipedia.org/wiki/Copa_Am%C3%A9rica")[9]

"""
for l in range(len(lista_tablas)):
    print(l)
    print(lista_tablas[l])
"""
print(lista_tablas.iloc[:10].set_index("Rank"))