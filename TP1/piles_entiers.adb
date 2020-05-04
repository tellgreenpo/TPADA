-- Auteurs : P. Esquirol
-- Version du 30/01/2019

-- Sous-programmes à compléter
-- Init_Pile
-- Est_Vide
-- Sommet
-- Empiler
-- Depiler
-- Hauteur
-- Liste_To_String
-- To_String

with Unchecked_Deallocation;

package body Piles_Entiers is

   procedure Free is new Unchecked_Deallocation(Cellule, Liste);
   -- Desallocation d'une Cellule pointee par un pointeur de type Liste
   -- Procedure utilisee lors des operations Depiler(P) et Vider(P)

   procedure Init(P : in out Pile) is
   -- Ne fait rien si P est deja vide a l'appel
   -- Sinon efface tous les elements de P (en
   -- recuperant la memoire allouee)
   -- et retourne la pile vide
   begin
      if P.Hauteur /= 0 then P := (null,0) ;
      end if ;
   end Init;

   function Est_Vide(P : in Pile) return Boolean is
   -- Retourne vrai si la pile est vide, faux sinon
   begin
      if P.Hauteur /= 0 then return False ;
      else return True ;
      end if ;
   end Est_Vide;

   function Sommet(P : in Pile) return Integer is
      -- Retourne le premier element de P (situe au sommet)
   begin
      if P.Hauteur = 0 then raise Pile_Vide ;
      end if ;
      return P.Debut.all.Info ;     
   end Sommet;

   procedure Empiler(E : in Integer; P : in out Pile) is
      -- Empile E au dessus de P ; E devient le nouveau sommet
   begin
      P := (new Cellule'(E,P.debut),P.Hauteur+1) ;
   end Empiler;

   procedure Depiler(P: in out Pile) is
   -- Efface le sommet de P ; attention, penser a recuperer
   -- la memoire associee a la cellule a effacer
      L : Liste ;
   begin
      if P.Hauteur = 0 then raise Pile_Vide ;
      end if ;
      L := P.debut ;
      P := (P.Debut.all.Suiv,P.Hauteur-1) ;
      Free(L);
   end Depiler;

   function Hauteur(P : in Pile) return Natural is
   -- Calculer la hauteur en comptant le nombre d'elements depilables
   -- n'est pas efficace. Cette fonction retourne directement le champ
   -- hauteur du record associe a une pile
   begin
      return P.Hauteur ;
   end Hauteur;

   function Liste_To_String(L : Liste) return String is
   -- Convertit une liste d'entiers en une chaine de caracteres
   begin
      if L.all.suiv = null then return "" ;
      else return Integer'image(L.all.Info)&(Liste_To_String(L.all.suiv)) ;
      end if ;
   end Liste_To_String;

   function To_String(P : in Pile) return String is
   -- Convertit une pile d'entiers en une chaine de caracteres
   begin
      if P.Hauteur = 0 then raise Pile_Vide ;end if ;
      return Liste_To_String(P.debut) ;
   end To_String;
   

   function "="(P1,P2 : in Pile) return Boolean is
      -- Verifie que les piles sont identiques (memes elements et meme ordre)
   begin
      if P1.Hauteur /= P2.Hauteur then return False ;
      elsif P1.debut = null then return True ;
      elsif P1.Debut.all.Info = P2.debut.all.Info then
	 return "="(P1.debut.all.Suiv,P2.debut.all.suiv) ;
      else return False ;
      end if ;
   end "=";





--   procedure Free_Liste(L : in out Liste) is
--   -- Desallocation de toutes les Cellules d'une Liste
--   begin
--      if L /= null then
--         Free_Liste(L.All.Suiv);  -- desallocation de la liste suivante PUIS
--         Free(L);                 -- desallocation de le premiere cellule
--      end if;
--      L := null;                  -- en principe c'est le cas apres Free(L)
--   end Free_Liste;

--   procedure Vider(P : in out Pile) is   -- pas indispensable pour le paquetage
--   begin
--                        --A COMPLETER EVENTUELLEMENT (reutiliser Free_Liste)
--   end Vider;

end Piles_Entiers;
