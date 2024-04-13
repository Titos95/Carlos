import argparse
import json

def filtro_vulnerabilidad(archivo, nivel):
   with open(archivo, 'r') as json_file:
   
      vulnerabilidades = json.load(json_file)
      
      for vulnerabilidad in vulnerabilidades:
          if vulnerabilidad["SEVERITY"] == nivel:
             print(f"Nº Vunerabilidad: {vulnerabilidad['ID_VUL']}")
             print(f"Paquete: {vulnerabilidad['PACKAGE']}")
             print(f"Nivel: {vulnerabilidad['SEVERITY']}")
             print(f"FIx: {vulnerabilidad['FIX']}")
             print(f"Referencia: {vulnerabilidad['CVE_Ref']}")
             print(f"url: {vulnerabilidad['V_URL']}")
             print(f"Tipo: {vulnerabilidad['TYPE']}")
             print(f"Feed: {vulnerabilidad['FEED']}")
             print(f"Path: {vulnerabilidad['PATH']}\n")
     
if __name__ == "__main__":
   parser = argparse.ArgumentParser();
   parser.add_argument("archivo")
   parser.add_argument("nivel")
   
   args = parser.parse_args()
   filtro_vulnerabilidad(args.archivo, args.nivel)
