with Ada.Unchecked_Deallocation;

package body Listes_Ordonnees_Entiers is
   
   -------------------------------------------------------------------------
   function "="(L1,L2 : in Une_Liste_Ordonnee_Entiers) return Boolean is
   begin
      if L1.Taille /= L2.Taille then return False;
      elsif L1.debut.all.Suiv = null then return True;
      elsif L1.debut.all.Info = L2.debut.all.Info then
	 return "="(L1.debut.all.Suiv,L2.debut.all.suiv);
      else return False;
      end if;
   end "=" ;
   
   -------------------------------------------------------------------------
   procedure Copie(L1 : in Une_Liste_Ordonnee_Entiers; L2 : out Une_Liste_Ordonnee_Entiers) is
   begin
      null ;
   end Copie ;


   -------------------------------------------------------------------------
   function Est_Vide(L : in Une_Liste_Ordonnee_Entiers) return Boolean is
   begin
      return L.Debut = null;
   end Est_Vide;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   function Cardinal(L : in Une_Liste_Ordonnee_Entiers) return Integer is
   begin
      return L.Taille;
   end Cardinal;
   -------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   -- Appartient classique sur une liste simplement chainee (type Lien) ordonnee

   function Appartient_Lien(E : Integer; LL : in Lien) return Boolean is
      Resultat :boolean;
   begin
      if LL = null or else E < LL.all.info then
         Resultat := False;         -- element non trouve
      elsif LL.all.Info = E then
         Resultat := True;          -- element trouve en 1ere place
      else
         Resultat := Appartient_Lien(E, LL.all.Suiv);  -- on cherche plus loin
      end if;
      return Resultat;
   end Appartient_Lien;

   -- Appartient sur le type Une_Liste_Ordonnee_Entiers
   -- On reutilise la fonction classique Appartient_Lien sur L.debut
   function Appartient(E : in integer; L : in Une_Liste_Ordonnee_Entiers) return Boolean is
   begin
      return Appartient_Lien(E, L.Debut);
   end Appartient;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   -- Conversion en chaine de caracteres
   --
   -- sur le type Lien

   function Lien_To_String(LL : in Lien) return String is
   begin
      if LL = null then return "";
      else return integer'image(LL.all.info) & Lien_To_String(LL.all.suiv);
      end if;
   end Lien_To_String;

   -- sur le type Une_Liste_Ordonnee_Entiers
   function Liste_To_String(L: in Une_Liste_Ordonnee_Entiers) return String is
   begin
      return Integer'Image(L.Taille) & " elements : (" & Lien_To_String(L.Debut) & " )";
   end Liste_To_String;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   -- Insertion ORDONNEE et SANS DOUBLON

   procedure Inserer_Lien(E: in Integer; L: in out Lien) is
      L1 : Lien ;
   begin
      if L = null then
	 L := new Cellule'(E,null);
      elsif Appartient_Lien(E,L) then raise Element_Deja_Present;
      elsif L.all.Info > E then
	 L1 := L;
	 L := new Cellule'(E,L1);
      elsif L.all.Suiv = null and E > L.all.info then
	 L.all.Suiv := new Cellule'(E,null);
      elsif L.all.Info < E and E < L.all.Suiv.all.Info then
	 L1 := L.all.Suiv;
	 L.all.suiv := new Cellule'(E,L1);
      else Inserer_Lien(E,L.all.suiv);
      end if;
      end Inserer_Lien;
   -- On desire une version RECURSIVE
   -- La procedure doit LEVER L'EXCEPTION Element_Deja_Present en
   -- cas de tentative d'insertion d'un doublon
   --   if Appartient_Lien(E, L.all.suiv) then raise Element_Deja_Present ;
   --   else
   --    while L.all.Suiv /= null loop
   --       if L.all.Info < E  and E < L.all.Suiv.all.Info
   --	    then
   --	       L1 := L.all.Suiv ;
   --	       L.all.Suiv := new access cellule'(E,L1) ;
   --	       else
   --		  Inserer_Lien(E,L.all.Suiv) ;
   --	    end if ;
   --	 end loop ;
   --   end if ;
   --   end Inserer_Lien;



   -------------------------------------------------------------------------
   procedure Inserer(E: in integer; L: in out Une_Liste_Ordonnee_Entiers) is
   begin
      Inserer_Lien(E,L.debut);
      L.Taille := L.Taille + 1;
   end Inserer;
   -------------------------------------------------------------------------


   -- Instanciation de Ada.Unchecked_Deallocation pour desallouer
   -- la memoire en cas de suppression des elements d'une liste
   -------------------------------------------------------------------------
   procedure Free is new Ada.Unchecked_Deallocation(Cellule, Lien);
   -------------------------------------------------------------------------
   procedure Supprimer_Lien(E : in Integer; L: in out Lien) is
      Recup : Lien;
   begin
      if L = null or else E < L.All.Info then
         raise Element_Non_Present;
      elsif E = L.All.Info then
         Recup := L;           -- on repere la cellule a recycler
         L     := L.All.Suiv;  -- on modifie le debut de la liste
         Free(Recup);          -- on recupere la memoire
      else
         Supprimer_Lien(E, L.all.suiv);
      end if;
   end Supprimer_Lien;
   -------------------------------------------------------------------------
   procedure Supprimer(E: in integer; L: in out Une_Liste_Ordonnee_Entiers) is
   begin
      Supprimer_Lien(E, L.debut);
      L.Taille := L.Taille - 1;
   end Supprimer;
   -------------------------------------------------------------------------

end Listes_Ordonnees_Entiers;
