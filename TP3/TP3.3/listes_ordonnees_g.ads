generic

   type Element is private;

   with function "<"(E1, E2 : in Element) return Boolean;

   with function "="(E1, E2 : in Element) return Boolean;

   with function Element_To_String(E : in Element) return String;

   with procedure Liberer_Element(E : in out Element);

package Listes_Ordonnees_G is

   type Une_Liste_Ordonnee is limited private;

   Element_Non_Present, Element_Deja_Present : exception;

   function Est_Vide(L : in Une_Liste_Ordonnee) return Boolean;

   function Cardinal(L : in Une_Liste_Ordonnee) return Natural;

   function Appartient(E : in Element ; L : in Une_Liste_Ordonnee) return Boolean;

   procedure Inserer(E: in Element ; L: in out Une_Liste_Ordonnee);

   procedure Supprimer(E: in Element ; L: in out Une_Liste_Ordonnee);

   function Liste_To_String(L: in Une_Liste_Ordonnee) return String;

   --ajouts de ss-programmes d'egalite et de copie
   function "="(L1, L2 : in Une_Liste_Ordonnee) return Boolean;
   procedure Copie(L1 : in Une_Liste_Ordonnee; L2 : out Une_Liste_Ordonnee);

   
   generic
      with function Critere(E : in Element) return Boolean;
   procedure Filtrage(L : in Une_Liste_Ordonnee; SL : out Une_Liste_Ordonnee);
   
   
   
private
   -- types classiques permettant de realiser des listes simplement chainees
   type Cellule;
   type Lien    is access Cellule;
   type Cellule is record
        Info : Element;
        Suiv : Lien;
   end record;

   -- type liste ameliore : record contenant la liste et sa taille
   -- (evite de parcourir la liste pour calculer la taille)

   type Une_Liste_Ordonnee is record
      Debut  : Lien    := null;
      Taille : Natural := 0;
   end record;
end Listes_Ordonnees_G;

