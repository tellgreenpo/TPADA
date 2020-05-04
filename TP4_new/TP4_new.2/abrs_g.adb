-- Date   : Janvier 2020
-- Auteur : P. Esquirol
--
-- Objet : corps paquetage arbre binaire de recherche generique
--
-- A FAIRE : COMPLETER LE CORPS DES SOUS-PROGRAMMES
-- REPERERES PAR   "<<<"

-----------------------------------------------------------------------------
with Ada.Text_Io, Unchecked_Deallocation;
use  Ada.Text_io;

package body Abrs_G is

   -----------------------------------------------------------------------------
   -- Desallocation de la structure Noeud

   procedure Free_Noeud IS NEW Unchecked_Deallocation(Noeud, Pt_Noeud);

   -- Desallocation complete d'un noeud et des sous-arbres droite et gauche

   procedure Liberer_Pt_Noeud(P : in out Pt_Noeud) is
   begin
      if P /= null then
         Liberer_Pt_Noeud(P.all.gauche); -- desallocation sous-arbre gauche
         Liberer_Pt_Noeud(P.all.droite); -- desallocation sous-arbre droite
         Liberer_Element(P.All.Info);    -- desallocation du contenu (info) du noeud racine
         Free_Noeud(P);                  -- desallocation de la structure noeud racine
      end if;
   end Liberer_Pt_Noeud;

   procedure Init_Abr(A : in out Abr) is
   -- Initialisation (ou re-initialisation d'un arbre). Apres appel, l'arbre est vide et toute
   -- la memoire dynamique occupee par l'arbre est desallouee.
   begin
      --                              <<<  Si A n'est pas vide, il faut desallouer
      --                                   toute la memoire utilisee par A
      --                                   et rendre un arbre vide (A.Debut = null et A.Taille = 0)
      Liberer_Pt_Noeud(A.debut);
      A.Taille := 0;
   end Init_Abr;
   -----------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   function Est_Vide(A : in Abr) return Boolean is
   -- Indique si A est devenu vide (par ex, apres des suppressions)
   begin
      return A.Taille = 0;           --<<< ... A COMPLETER
   end Est_Vide;
   -----------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   function Taille(A : in Abr) return Natural is
  -- indique le nb courant d'elements (de noeuds) dans A (0 si A est vide)
   begin


      return A.taille;           --<<< ... A COMPLETER
   end Taille;
   -----------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   procedure Racine(A: in Abr; E : out Element) is
   -- leve l'exception Abr_Vide si A est vide et n'a pas de racine ;
   -- sinon retourne une copie de l'element situe a la racine de A.
   begin
      if Est_Vide(A) then
         raise Abr_Vide;
      else
         Copy(A.Debut.All.Info, E);
      end if;
   end Racine;
   -----------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   procedure Rechercher_Lien(C : in Cle; P : in Pt_Noeud; Trouve : out Boolean ; E : out Element) is
   begin
      --                  <<<      A COMPLETER : il y a 4 CAS  a traiter
      --
      --                           - P = null                    (C pas trouvee)
      --                           - C = cle_de(P.All.info)      (C trouvee et  E = P.all.info)
      --                           - C < cle_de(P.All.info)      (il faut chercher C a gauche)
      --                           - cle_de(P.All.info) < C      (il faut chercher C a droite)
      if P=null then
	 Trouve := False;
	 Put("Clé pas trouvée");
      elsif C = Cle_De(P.all.info) then
	Copy(P.all.Info,E) ;
	Trouve := True;
	Put("Clé trouvée");
      elsif C < Cle_De(P.all.Info) then
	 Rechercher_Lien(C,P.all.Gauche,Trouve,E);
      else
	 Rechercher_Lien(C,P.all.Droite,Trouve,E);
      end if;
   end Rechercher_Lien;
   -----------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   procedure Rechercher(C : in Cle ; A : in Abr; Trouve : out boolean; E : out Element) is
   -- indique pour une cle donnee C si A contient un element qui a cette cle,
   -- et si oui retourne une copie de cet element.
   begin
      if A.Taille = 0 then
         raise Abr_Vide;
      else
         Rechercher_Lien(C, A.Debut, Trouve, E);
      end if;
   end Rechercher;
   -----------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   function Lien_To_String(P : in Pt_Noeud) return String is
   begin
      if P = null then
         return "";
      else
         return
            Lien_To_String(P.All.Gauche) &
            Element_To_String(P.all.Info) & ASCII.LF &
            Lien_To_String(P.All.Droite);
      end if;
   end Lien_To_String;

   function Abr_To_String(A : in Abr) return String is
   -- retourne un String compose de la conversion en string de tous les elements de A apres un parcours infixe (Gauche-Racine-Droite)
   begin
      return ASCII.LF &
         Integer'Image(A.Taille) & " elements :" & ASCII.LF & ASCII.LF &
         Lien_To_String(A.Debut) & ASCII.LF;
   end Abr_To_String;
   -----------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   procedure Put90_Lien(P: in Pt_Noeud; Str : String := "") is
   begin
      if P /= null then
         if P = P.All.Gauche or P = P.all.droite then
            raise Data_Error;
         else
            Put90_Lien(P.All.Droite, Str & "   ");
            Put_Line(Str & Element_To_String(P.All.Info));
            Put90_Lien(P.All.Gauche, Str & "   ");
         end if;
       end if;
   end Put90_Lien;

   procedure Put90(A : in Abr) is
   -- Procedure d'affichage couche : un element par ligne avec indentation fonction de la profondeur de l'element dans l'arbre.
   begin
      Put90_Lien(A.Debut,"");
   end Put90;


  -----------------------------------------------------------------------------
   procedure Inserer_Lien(E : in Element; P : in out Pt_Noeud) is
   begin
      if P = null then
	 P := new Noeud;
	 Copy(E,P.all.info);
      elsif Cle_De(E) = Cle_De(P.all.Info) then raise Element_Deja_Present;
      elsif Cle_De(P.all.info) < Cle_De(E) then Inserer_Lien(E,P.all.Droite);
      else Inserer_Lien(E,P.all.gauche);
      end if;
   end Inserer_Lien;


   procedure Inserer(E : Element; A : in out Abr) is
   begin
      -- Appellee Inserer_Lien(E, A.debut)

      -- Une exception sera levee a la ligne si E est deja present

      -- Ne pas oublier d'incrementer A.Taille
      Inserer_Lien(E,A.debut);
      A.Taille := A.Taille + 1;
   end Inserer;
   -----------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   -- SUPPRESSION
   -- VERSION RECURSIVE DONNEE EN COURS

      procedure Enlever_Max(A : in out Pt_Noeud ; Max_G : out Element) is
         Recup : Pt_Noeud;  -- va pointer sur le noeud a desallouer
      begin		          -- la procedure n'est jamais appelee avec A = null
         if A.all.Droite = null then
            Copy(A.all.info, Max_G);
            Recup := A;
            A     := A.all.Gauche;     -- A pointe sur son fils gauche
            Free_Noeud(Recup);         -- on recupere le noeud desalloue
         else
            Enlever_Max(A.all.Droite, Max_G);
         end if;
      end Enlever_Max;


   procedure Supprimer_Lien(E : in Element; P : in out Pt_Noeud ) is
      Val_Max : Element;
      C       : Cle;
      Recup   : Pt_Noeud;
   begin
      C := Cle_De(E);
      if P = null then
         raise Element_Non_Present;
      else -- P /= null
         if C < Cle_De(P.All.Info) then
            Supprimer_Lien(E, P.all.Gauche);
         elsif Cle_De(P.All.Info) < C then
            Supprimer_Lien(E, P.all.Droite);
         else -- on a trouve : Cle_De(C) = Cle_De(P.all.info)
            if P.All.Gauche = null then
               Recup := P;
               P     := P.All.Droite;
               Liberer_Element(Recup.All.Info);    -- desallocation contenu du noeud racine
               Free_Noeud(Recup);                  -- desallocation noeud racine
            elsif P.All.Droite = null then
               Recup := P;
               P     := P.All.Gauche;
               Liberer_Element(Recup.All.Info);    -- desallocation contenu du noeud racine
               Free_Noeud(Recup);                  -- desallocation noeud racine
            else
               Enlever_Max(P.All.Gauche, Val_Max); -- va chercher la valeur max et enlenve 
	       Copy(Val_Max, P.all.info);          -- mise a jour de la racine val_max a la place de E
            end if;
         end if;
      end if;
   end Supprimer_Lien;

   procedure Supprimer(E: in Element; A : in out Abr) is
   -- Si E se trouve dans A, supprime le noeud associe
   -- sinon leve l'exception Element_Non_Present.
   begin
      -- Appelle Supprimer_Lien(E, A.Debut);
      -- Si E n'est pas present, une exception sera levee a la ligne qui precede
      -- Ne pas oublier de decrementer A.Taille
      Supprimer_Lien(E,A.debut);
      A.Taille := A.Taille -1 ;
   end Supprimer;
   -----------------------------------------------------------------------------

end Abrs_G;



