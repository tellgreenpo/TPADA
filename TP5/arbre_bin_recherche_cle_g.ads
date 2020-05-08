-- Date : Mars 2015
-- Auteur : MJ. Huguet
-- 
-- Objet : specification arbre binaire de recherche generique
-- 
-- Remarque : 
--  	les elements disposent d'une cle permettant de les identifier
-----------------------------------------------------------------------------
generic
   type Element is private;
   type Key is private;
   with function Cle_De(E : in Element) return Key;
   with function "<"(C1, C2 : in Key) return Boolean;
   with function "="(C1, C2 : in Key) return Boolean;
   with procedure Liberer_Element(E : in out Element);
   with function Element_To_String(E : in Element) return String;   
package Arbre_Binaire_Recherche_G is
      Element_Deja_Present, Element_Non_Present, Arbre_Vide : exception;

      type Arbre is limited private;  -- A la declaration un arbre est initialise (arbre vide)

      procedure Liberer(A : in out Arbre);
      function Est_Vide(A : in Arbre) return Boolean;
      function Taille(A : in Arbre) return Natural;
      function Racine(A: in Arbre) return Element; -- peut lever l'exception Arbre_Vide
      
      -- function Appartient(E : in Element; A : in Arbre) return Boolean;
      function Appartient(C : in Key; A : in Arbre) return Boolean;
      
      -- Chaine correspondant a un parcours infixe (Gauche-Racine-Droite)
      function Arbre_To_String(A : in Arbre) return string;

      procedure Inserer(E: in Element; A: in out Arbre );    -- peut lever l'exception Element_Deja_Present
      procedure Supprimer(E : in Element; A : in out Arbre); -- peut lever l'exception Element_Non_Present
      

      function Rechercher_Par_Cle(C: in Key; A : in Arbre) return Element;
      
      
      
      
      --function Sous_Arbre_Gauche(A : in Arbre) return Arbre;
      --function Sous_Arbre_Droit(A : in Arbre) return Arbre;
	  
      -- parcourir infixe
      --generic
      --   with procedure Traiter(E : in Element);
      --procedure Parcourir_GRD(A : in Arbre);

      --procedure Impression_Couchee(A : in Arbre; Decalage : in String:= "");
      
      
      --      Tab_Recherche : ARRAY(1..2) OF Natural := (0, 0);
      -- Tab_Resu(1) ==> nb test
      -- Tab_Resu(2) ==> nb parcours
      --      Tab_Recherche_Ordre : ARRAY(1..2) OF Natural := (0, 0);
      -- Tab_Resu(1) ==> nb test
      -- Tab_Resu(2) ==> nb parcours

   
     -- Fonction permettant de rechercher dans la liste les elements verifiant
      -- certaines proprietes (exprimees dans Filtrer)
      --generic
      --   with function Filtrer(E1, E2 : in Element) return boolean;
      --function Rechercher(E : in Element; A : in Arbre) return Arbre;

      -- Fonction permettant de rechercher dans la liste les elements verifiant
      -- certaines proprietes (exprimees dans Filtrer) et avec des conditions
      -- d'arrêt de la recherche
      --generic
      --   with function Filtrer(E1, E2 : in Element) return Boolean;
      --   with function Direction_Filtrer(E1, E2 : in Element) return Boolean;
      --function Rechercher_Ordre(E : in Element; A : in Arbre) return Arbre;


private
      type Noeud;

      type LienArbre is access Noeud;
      type Noeud is record
         Info : Element;
         Gauche : LienArbre;
         Droite : LienArbre;
      end record;
	  
      type Arbre is record
	 Debut : LienArbre := null;
	 Taille : natural := 0;
      end record;

END Arbre_Binaire_Recherche_g;

