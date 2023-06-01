import os
import re

import pandas
import requests


def read_csv(nom_fichier):
    df = pandas.read_csv(nom_fichier)
    return df.stack().astype(str).str.findall(r'\bhttps?://\S+\.pdf\b').sum() #va chercher tout ceux qui commence par http:// ou https:// et fini par .pdf

def save_all_pdf(pdf_links, chemin_dossier):
    dossier_path = chemin_dossier + "\\dossierPDF"
    if not os.path.exists(dossier_path):
        os.mkdir(dossier_path)

    for url in pdf_links:
        nom_fichier = re.search(r"/([^/]+)$", url).group(1)
        chemin_fichier = chemin_dossier + "\\dossierPDF\\" + nom_fichier
        #print("URL : ", url, "\nchemin du fichier :", chemin_fichier)
        if not os.path.exists(chemin_fichier):
            print("Ajout du fichier", nom_fichier, "\n\t Lien :", chemin_fichier)
            try:
                save_pdf(url, dossier_path, nom_fichier)
            except:
                print("Erreur sur la ligne")



def save_pdf(url, chemin_dossier, nom_fichier):
    # Télécharger le fichier à partir de l'URL
    response = requests.get(url)
    # Sauvegarder le fichier dans le dossier destination
    with open(os.path.join(chemin_dossier, nom_fichier), "wb") as f:
        f.write(response.content)


if __name__ == '__main__':
    print("--- Début du processus ---")
    chemin_fichier = "C:\\Users\\coral\\switchdrive\\Semestre-2\\M6\\Data curation\\clean_data"
    nom_fichier = "pdf.csv"
    save_all_pdf(read_csv(nom_fichier), chemin_fichier)
    print("--- Fin du processus ---")
