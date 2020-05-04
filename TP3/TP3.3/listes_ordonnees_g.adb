with Ada.Unchecked_Deallocation;

package body Listes_Ordonnees_G is

   -------------------------------------------------------------------------
   function Est_Vide(L : in Une_Liste_Ordonnee) return Boolean is
   begin
      return L.Debut = null;
   end Est_Vide;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   function Cardinal(L : in Une_Liste_Ordonnee) return Natural is
   begin
      return L.Taille;
   end Cardinal;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   -- Appartient classique sur une liste simplement chainee (type Lien)

   function Appartient_Lien(E : Element; LL : in Lien) return Boolean is
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

   -- Appartient sur le type Une_Liste_Ordonnee_G
   -- On reutilise la fonction classique Appartient_Lien sur L.debut
   function Appartient(E : in Element; L : in Une_Liste_Ordonnee) return Boolean is
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
                   else return Element_To_String(LL.all.info) &ASCII.LF & Lien_To_String(LL.all.suiv);
      end if;
   end Lien_To_String;

   -- sur le type Une_Liste_Ordonnee_Entiers
   function Liste_To_String(L: in Une_Liste_Ordonnee) return String is
   begin
      return Integer'Image(L.Taille) & " elements : "& ASCII.LF & Lien_To_String(L.Debut);
   end Liste_To_String;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   -- Insertion ORDONNEE et SANS DOUBLON

   procedure Inserer_Lien(E: in Element; L: in out Lien) is
   begin
      if L = null or else E < L.All.Info then
         L := new Cellule'(E, L);
      elsif E = L.All.Info then
         raise Element_Deja_Present;
      else
         Inserer_Lien(E, L.All.Suiv);
      end if;
   end Inserer_Lien;

   -------------------------------------------------------------------------
   procedure Inserer(E: in Element; L: in out Une_Liste_Ordonnee) is
   begin
      Inserer_Lien(E, L.Debut);
      L.Taille := L.Taille+1;
      -- Remarque : l'exception eventuellement levee en cas de doublon
      --            par le ss-prog Inserer_Lien (Element_Deja_Present)
      --            n'etant pas traitee, cela empeche d'augmenter la taille ...
      --            Cette exception n'etant pas traitee, elle se propage au niveau
      --            appelant.
   end Inserer;
   -------------------------------------------------------------------------


   -- Instanciation de Ada.Unchecked_Deallocation pour desallouer
   -- la memoire en cas de suppression des elements d'une liste
   -------------------------------------------------------------------------
   procedure Free is new Ada.Unchecked_Deallocation(Cellule, Lien);
   -------------------------------------------------------------------------
   procedure Supprimer_Lien(E : in Element; L: in out Lien) is
      Recup : Lien;
   begin
      if L = null or else E < L.All.Info then
         raise Element_Non_Present;
      elsif E = L.All.Info then
         Recup := L;           -- on repere la cellule a recycler
         L     := L.All.Suiv;  -- on modifie le debut de la liste
         Liberer_Element(Recup.all.info); --on recupere la memoire associee a l'element
         Free(Recup);          -- on recupere la memoire associee a la cellule contenant l'element
      else
         Supprimer_Lien(E, L.all.suiv);
      end if;
   end Supprimer_Lien;
   -------------------------------------------------------------------------
   procedure Supprimer(E: in Element; L: in out Une_Liste_Ordonnee) is
   begin
      Supprimer_Lien(E, L.debut);
      L.Taille := L.Taille - 1;
      -- Remarque : l'exception eventuellement levee par le ss-prog
      --            Supprimer_Lien (Element_Non_Present)
      --            n'etant pas traitee, cela empeche de diminuer la taille ...
      --            Cette exception n'etant pas traitee, elle se propage au niveau
      --            appelant.
   end Supprimer;
   -------------------------------------------------------------------------

   --ajouts de ss-programmes d'egalite et de copie
   function Identiques(L1, L2 : in Lien) return Boolean is
      idem : boolean;
   begin
      if L1 = null and L2=null then
         Idem := TRUE; --les deux listes sont vides donc identiques
      elsif L1 = null or L2 = null then
         Idem := FALSE; --une seule des deux listes est vide donc elles sont differentes
      else
         Idem := (L1.All.Info = L2.All.Info) and then Identiques (L1.All.Suiv, L2.All.Suiv);
         -- le "and then" evite l'appel recursif si les 2 premiers elements sont differents
         -- c'est suffisant pour affirmer que L1 et L2 sont differentes
      end if;
      return Idem;
   end Identiques;

   -------------------------------------------------------------------------

   function "="(L1,L2 : in Une_Liste_Ordonnee) return Boolean is
   begin
      return L1.Taille = L2.Taille and then Identiques(L1.debut,L2.debut);
   end "=";

   -------------------------------------------------------------------------
   function Copie(L1 : in Lien) return Lien is
   begin
      if L1 = null then return null;
                   else return new Cellule'(L1.All.Info, Copie(L1.All.Suiv));
      end if;
   end Copie;
   -------------------------------------------------------------------------

   procedure Copie(L1 : in Une_Liste_Ordonnee; L2 : out Une_Liste_Ordonnee) is
   begin
      L2 := (Debut => Copie(L1.Debut), Taille => L1.Taille);
   end Copie;

   -------------------------------------------------------------------------
   procedure Filtrage( L :in Une_Liste_Ordonnee;Sl : out Une_Liste_Ordonnee) is
      L1 : Lien;
   begin
      L1 := L.Debut;
      while L1 /= null loop
	 if Critere(L1.all.info) then
	    Inserer(L1.all.Info,SL);
	 end if;
	 L1 := L1.all.Suiv;
      end loop;
   end Filtrage ;
   --------------------------------------------------------------------------
   
end Listes_Ordonnees_G;
