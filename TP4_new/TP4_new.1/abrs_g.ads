-- Date   : janvier 2020
-- Auteur : P. Esquirol
--
-- Objet : specification paquetage arbre binaire de recherche generique
--
-- CONSIGNES
--      LIRE ET COMPRENDRE LA DECLARATION DES TYPES (Abr, Pt_Noeud, Noeud)
--      COMPLETER LES LIGNES INDIQUEES "<<<"
-----------------------------------------------------------------------------

generic

   -- *********************************
   -- Zone des parametres de genericite (associes a un Element)
   -- *********************************

   type Element is limited private;  -- ex : un objet en general caracterise par plusieurs informations.
                                     -- on suppose qu'un Element est un type pour lequel les operations de base
                                     -- "=" "<" et ":=" peuvent etre interdites (presence de pointeurs)
                                     -- et doivent donc etre redefinies

   type Cle is private;              -- ex : le numero INSEE ou le numero de telephone dans le cas d'une personne

   with function Cle_De(E : in Element) return Cle;
   -- la fonction qui determine la cle d'un Element

   with function "="(C1,C2 :in Cle) return Boolean;
   -- la fonction qui indique que 2 cles sont identiques

   with function "<"(C1, C2 :in Cle) return Boolean;
   -- la fonction qui indique si 2 cles sont strictement ordonnees

   with procedure Liberer_Element(E : in out Element);
   -- la procedure qui permet de desallouer la memoire reservee dynamiquement pour creer un Element

   with function Element_To_String(E : in Element) return String;
   --la fonction qui convertit un Element en une chaine de caracteres

   with procedure Copy(E1 : in Element; E2 : out Element);
   -- la procedure qui permet de creer un element identique (copie profonde)



package Abrs_G is

   type Abr is limited private;

   Element_Deja_Present, Element_Non_Present, Abr_Vide : exception;

   procedure Init_Abr(A : in out Abr);
   -- Initialisation (ou re-initialisation d'un arbre). Apres appel, l'arbre est vide et toute
   -- la memoire dynamique occupee par l'arbre est desallouee.

   function Est_Vide(A : in Abr) return Boolean;
   -- Indique si A est devenu vide (par ex, apres des suppressions)

   function  Taille(A : in Abr) return Natural;
   -- indique le nb courant d'elements (de noeuds) dans A (0 si A est vide)

   procedure Racine(A: in Abr; E : out Element);
   -- leve l'exception Abr_Vide si A est vide et n'a pas de racine ;
   -- sinon retourne une copie de l'element situe a la racine de A.

   procedure Rechercher(C : in Cle ; A : in Abr; Trouve : out boolean; E : out Element);
   -- indique pour une cle donnee C si A contient un element qui a cette cle,
   -- et si oui retourne une copie de cet element.

   function Abr_To_String(A : in Abr) return string;
   -- retourne un String compose de la conversion en string de tous les elements de A apres un parcours infixe (Gauche-Racine-Droite)

   procedure Put90(A : in Abr);
   -- Procedure d'affichage couche : un element par ligne avec indentation fonction de la profondeur de l'element dans l'arbre.

   procedure Inserer(E: in Element; A: in out Abr );
   -- Insere une copie de E dans l'arbre A, sauf s'il y etait deja ;
   -- dans ce cas leve l'exception Element_Deja_Present.

   procedure Supprimer(E : in Element; A : in out Abr);
   -- Si E se trouve dans A, supprime le noeud associe
   -- sinon leve l'exception Element_Non_Present.


private

   type Noeud;

   type Pt_Noeud is access Noeud;

   type Noeud is record
      Info   : Element;
      Gauche : Pt_Noeud;
      Droite : Pt_Noeud;
   end record;

   type Abr is record
      Debut  : Pt_Noeud := null; -- A la declaration, un Abr est vide
	Taille : natural  := 0;
   end record;

end Abrs_G;

