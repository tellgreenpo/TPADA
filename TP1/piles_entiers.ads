-- Auteurs : P. Esquirol
-- Version du 30/01/2019

package Piles_Entiers is

   type Pile is limited private;

   Pile_Vide : exception;
   -- exception levee si on tente d'acceder au sommet d'une pile vide
   -- ou si on tente de depiler une pile vide.

   -- ****************************************
   -- OPERATIONS INDISPENSABLES DU T.A.D. PILE
   -- ****************************************

   procedure Init(P : in out Pile);
   -- Ne fait rien si P est deja vide a l'appel
   -- Sinon efface tous les elements de P (en
   -- recuperant la memoire allouee)
   -- et retourne la pile vide

   function  Est_Vide(P : in Pile) return Boolean;
   -- Retourne vrai si la pile est vide, faux sinon

   function  Sommet(P : in Pile) return Integer;
   -- Retourne le premier element de P (situe au sommet)

   procedure Empiler(E : in Integer; P : in out Pile);
   -- Empile E au dessus de P ; E devient le nouveau sommet

   procedure Depiler(P: in out Pile);
   -- Efface le sommet de P ; attention, penser a recuperer
   -- la memoire associee a la cellule a effacer

   -- **************************************
   -- OPERATIONS FACULTATIVES DU T.A.D. PILE
   -- **************************************

   function Hauteur(P : in Pile) return Natural;
   -- Calculer la hauteur en comptant le nombre d'elements depilables
   -- n'est pas efficace. Cette fonction accede directement au champ
   -- hauteur du record associe a une pile

   function To_String(P : in Pile) return String;
   -- Convertit une pile d'entiers en une chaine de caracteres

   function "="(P1,P2 : in Pile) return boolean;
   -- Verifie que les piles sont identiques (memes elements et meme ordre)

private
   type Cellule;
   type Liste   is access Cellule;
   type Cellule is record
        Info : Integer;
        Suiv : Liste;
   end record;

   type Pile is record
        Debut  : Liste   := null;
        Hauteur: Natural := 0;
   end record;

end Piles_Entiers;
