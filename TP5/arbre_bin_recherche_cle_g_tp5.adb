-- Date : Mars 2015
-- Auteur : MJ. Huguet
-- 
-- Objet : corps arbre binaire de recherche generique
-- Remarque : 
--  	les elements disposent d'une cle permettant de les identifier
-----------------------------------------------------------------------------
with Unchecked_Deallocation;

package body Arbre_Binaire_Recherche_G is
   
   -----------------------------------------------------------------------------
   -- Definir l'egalite sur des elements comme l'egalite sur la cle
   -- c'est quand meme un peu ose; ça blinde !
   function "="(E1, E2 : Element) return Boolean is
   begin
      return Cle_De(E1)=Cle_De(E2);
   end "=";
   function "<"(E1, E2 : Element) return Boolean is
   begin
      return Cle_De(E1)<Cle_De(E2);
   end "<";
   
   
   -----------------------------------------------------------------------------
   procedure Free_Noeud is new Unchecked_Deallocation(Noeud, LienArbre);
   
   procedure Liberer_Lien(LA : in out LienArbre) is
   begin
      if LA /= null then
         Liberer_Lien(LA.all.gauche); -- desallocation partie gauche
         Liberer_Lien(LA.all.droite); -- desallocation partie droite
         Liberer_Element(LA.All.Info);   -- desallocation contenu du noeud racine
         Free_Noeud(LA);              -- desallocation noeud racine
      end if;
   end Liberer_Lien;
   
   procedure Liberer(A : in out Arbre) is
   begin
      Liberer_Lien(A.Debut);
      A.Debut := null;
      A.Taille := 0;
   end Liberer;
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   function Est_Vide(A : in Arbre) return Boolean is
   begin
      return A.Debut=null;
   end Est_Vide;
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   function Taille(A : in Arbre) return Natural is
   begin
      return A.Taille;
   end Taille;
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   function Racine(A: in Arbre) return Element is
   begin
      if Est_Vide(A) then
	 raise Arbre_Vide;
      else
	 return A.Debut.all.Info;
      end if;
   end Racine;
   -----------------------------------------------------------------------------
   
   -----------------------------------------------------------------------------
   -- Appartient sur un Element
   --  function Appartient_Lien(E : in Element; LA : in LienArbre) return Boolean is
   --  begin
   --     if LA = null then
   --        return False;
   --     else
   --        if E = LA.All.Info then
   --           return True;
   --        elsif E < LA.All.Info then
   --           return Appartient_Lien(E, LA.All.Gauche);
   --        else
   --           return Appartient_Lien(E, LA.All.Droite);
   --        end if;
   --     end if;
   --  end Appartient_Lien;
   --  function Appartient(E : in Element; A : in Arbre) return Boolean is
   --  begin
   --     return Appartient_Lien(E, A.Debut);
   --  end Appartient;
   
   -- Apartient sur une Cle
   function Appartient_Lien(C : in Key; LA : in LienArbre) return Boolean is
   begin
      if LA = null then
         return False;
      else
         if C = Cle_De(LA.All.Info) then
            return True;
         elsif C < Cle_De(LA.All.Info) then
            return Appartient_Lien(C, LA.All.Gauche);
         else
            return Appartient_Lien(C, LA.All.Droite);
         end if;
      end if;
   end Appartient_Lien;
   function Appartient(C : in Key; A : in Arbre) return Boolean is
   begin
      return Appartient_Lien(C, A.Debut);
   end Appartient;
   -----------------------------------------------------------------------------
   
   -----------------------------------------------------------------------------

   function Lien_To_String(LA : in LienArbre) return String IS
   begin
      if LA /= null then
         return (Lien_To_String(LA.All.Gauche) & Element_To_String(LA.all.Info) & Lien_To_String(LA.All.Droite));
      else
         return "";
      end if;
   end Lien_To_String;

   function Arbre_To_String(A : in Arbre) return String is
   begin
      return Integer'Image(A.Taille) & " elements : (" & Lien_To_String(A.Debut) & " )";
   end Arbre_To_String;
   -----------------------------------------------------------------------------
   
   -----------------------------------------------------------------------------
   procedure Inserer_Lien(E : in Element; LA : in out LienArbre) is
      -- VERSION ITERATIVE
      Auxi : LienArbre;
      Insertion_Ok : Boolean;
   begin
      if LA = null then
         LA := new Noeud'(E, null,null);
      else
         Auxi := LA;
         Insertion_Ok := FALSE;
         while not Insertion_Ok loop
            if E = Auxi.All.Info then
               raise Element_Deja_Present;
            elsif E < Auxi.All.Info then
               if Auxi.All.Gauche = null then -- fils gauche de Auxi = place libre ?
                                              -- oui => insertion
                  Auxi.All.Gauche := new Noeud'(E, null, null);
                  Insertion_Ok := TRUE; -- pour sortir de la boucle while
               else --non => descente a gauche
                  Auxi := Auxi.All.Gauche;
               end if;
            else -- E > Auxi.All.Info
               if Auxi.All.Droite= null then -- fils droite de Auxi = place libre ?
                                             -- oui => insertion
                  Auxi.All.Droite:= new Noeud'(E, null, null) ;
                  Insertion_Ok := TRUE; --pour sortir de la boucle while
               else --non => descente a Droite
                  Auxi := Auxi.All.Droite;
               end if;
            end if;
         end loop;
      end if;
   end Inserer_Lien;

   procedure Inserer(E : Element; A : in out Arbre) is
   begin
      Inserer_Lien(E, A.Debut);
      A.Taille := A.Taille + 1;
   end Inserer;
   -----------------------------------------------------------------------------
   
   -----------------------------------------------------------------------------
   procedure Supprimer_Maxg(LA : in out LienArbre;
			    Maxg : out Element) is
      Recup : LienArbre;
   begin
      if LA.All.Droite = null then
         MaxG := LA.All.Info;
         Recup := LA;
         LA := LA.All.Gauche;
         Free_Noeud(Recup);
      else
         Supprimer_Maxg(LA.All.Droite, Maxg);
      end if;
   end Supprimer_Maxg;
   
   procedure Supprimer_Lien(E : in Element; LA : in out LienArbre ) is
      -- VERSION RECURSIVE DONNEE EN COURS
      Mg : Element;
      Recup : LienArbre;
   begin
      if LA = null then
	 raise Element_Non_Present;
      else
	 -- LA n'est pas vide
	 if E = LA.All.Info then -- on a trouve E a la racine de LA
	    if LA.All.Gauche = null then
	       --E n'as pas de fils gauche
	       Recup := LA;
	       LA := LA.All.Droite;
	       Free_Noeud(Recup);
	    else
	       --E a un sous-arbre gauche on cherche le plus grand de ses descendants gauche
	       Supprimer_Maxg(LA.All.Gauche, Mg);
	       LA.All.Info := Mg;
	    end if;
	 else --E n'est pas a la racine de LA
	    if E < LA.All.Info then
	       Supprimer_Lien(E, LA.All.Gauche);
	    else
	       Supprimer_Lien(E, LA.All.Droite);
	    end if;
	 end if;
      end if;
   end Supprimer_Lien;
   
   procedure Supprimer(E : in Element; A : in out Arbre) is
   begin
      Supprimer_Lien(E, A.Debut);
      A.Taille := A.Taille - 1;
   end Supprimer;
   -----------------------------------------------------------------------------
   
   
   
   
   
   
   
   -----------------------------------------------------------------------------
   function Rechercher_Lien(C : in Key; LA : in LienArbre) return Element is
   begin
      if LA = null then
         raise Element_Non_Present;
      else
         if C = Cle_De(LA.All.Info) then
            return LA.all.Info;
         elsif C < Cle_De(LA.All.Info) then
            return Rechercher_Lien(C, LA.All.Gauche);
         else
            return Rechercher_Lien(C, LA.All.Droite);
         end if;
      end if;
   end Rechercher_Lien;
   
   
   function Rechercher_Par_Cle(C: in Key; A : in Arbre) return Element is
   begin
      return Rechercher_Lien(C, A.Debut);
   end Rechercher_Par_Cle;
   
   
   --    PROCEDURE Parcourir_GRD(A : IN Arbre) IS
   --     BEGIN
   --        IF A /= NULL THEN
   --           Parcourir_GRD(A.All.Gauche);
--           Traiter(A.All.Info);
--           Parcourir_GRD(A.All.Droite);
--        END IF;
--     END Parcourir_GRD;


--  --   procedure Actualiser(E : in Element; A : in Arbre) is
--  --   begin
--  --      if A = null then
--  --         raise Element_Inexistant;
--  --      elsif E = A.All.Info then
--  --         A.All.Info := E;
--  --      elsif E < A.All.Info then
--  --         Actualiser(E,A.All.Gauche);
--  --      else
--  --         Actualiser(E, A.All.Droite);
--  --      end if;
--  --   END Actualiser;



--   procedure Supprimer(E : in Element; A : in out Arbre) is
--   --VERSION ITERATIVE
--      Mg : Element;
--      Recup, Suiv, Pere, Fils : Arbre;
--      Trouve : Boolean; --passe a TRUE si on trouve un noeud contenant E
--      Lien_Gauche : boolean; --TRUE si Fils est le fils gauche de Pere, et FALSE si c'est le fils droit
--   begin
--      if A = null then raise Element_Inexistant; --cas ou on veut supprimer un element inexistant
--      else -- on est sur que A n'est pas vide
--           -- on traite d'abord le cas de la racine de A
--         if E = A.All.Info then
--            -- on a trouve E dans la racine de A
--            if Est_Vide(A.All.Gauche) then
--               Recup := A;
--               A := A.All.Droite;
--               Free_Noeud(Recup);
--            elsif Est_Vide(A.All.Droite) then
--               Recup := A;
--               A := A.All.Gauche;
--               Free_Noeud(Recup);
--            else
--               Supprimer_MaxG(A.All.Gauche, Mg);
--               A.All.Info := Mg;
--            END IF;
--         else -- on n'a pas trouve E à la racine de A et on doit chercher à gauche ou a droite
--            Trouve := False;
--            Pere := A; -- on sait que A n'est pas vide
--            if E < Pere.All.Info then
--               -- on doit chercher à gauche
--               Fils := Pere.All.Gauche;
--               Lien_Gauche := TRUE; -- on se souvient que Fils est le fils gauche de Pere
--            else
--               -- on doit chercher a droite
--               Fils := Pere.All.Droite;
--               Lien_Gauche := FALSE; -- on se souvient que Fils est le fils droite de Pere
--            end if;
--            while not Est_Vide(Fils) and not Trouve loop --tant que l'arbre courant n'est pas vide et qu'on n'a pas trouve
--               if E = Fils.All.Info then --ca y est on a trouve E
--                  TROUVE := TRUE;
--                  if Est_vide(Fils .all.gauche) or else Est_vide(Fils .all.Droite) then
--                     if Est_Vide(Fils.All.Gauche) then
--                        Recup := Fils;
--                        Suiv := Fils.All.Droite;
--                        Free_Noeud(Recup);
--                     else
--                        Recup := Fils;
--                        Suiv := Fils.All.Gauche;
--                        Free_Noeud(Recup);
--                     end if;
--                     if Lien_Gauche then
--                        Pere.All.Gauche := Suiv;
--                     else
--                        Pere.All.Droite := Suiv;
--                     end if;
--                  else -- Fils contient E et il a lui-meme 2 fils non vides
--                     Supprimer_MaxG(Fils.All.Gauche, Mg);
--                     Fils.All.Info := Mg;
--                  END IF;
--               elsif E < Fils.All.info then --on n'a pas trouve et on doit descendre a gauche
--                  Pere := Fils;
--                  Fils := Pere.All.Gauche;
--                  Lien_Gauche := TRUE;
--               else --on n'a pas trouve et on doit descendre a droite
--                  Pere := Fils;
--                  Fils := Pere.All.Droite;
--                  Lien_Gauche := FALSE;
--               end if;
--            end loop;
--            -- si on est sorti de la boucle parce que Fils est vide, on leve une exception
--            if Est_Vide(Fils) then raise Element_Inexistant; end if;
--         end if;
--      end if;
--   end Supprimer;

 

--    -- Ajouter les elements de l'arbre B dans l'arbre A
--   PROCEDURE Concatener(A : IN OUT Arbre; B : IN Arbre) IS
--   BEGIN
--      IF NOT Est_Vide(B) THEN
--         Inserer(Racine(B), A);
--         Concatener(A, Sous_Arbre_Gauche(B));
--         Concatener(A, Sous_Arbre_Droit(B));
--      END IF;
--   END Concatener;

--  -- Cpt1_Test : Natural := 0;
--  -- cpt1_parc : natural := 0;
--       -- Fonction permettant de rechercher dans la liste les elements verifiant
--        -- certaines proprietes (exprimees dans Filtrer)
--  --      GENERIC
--  --         with function Filtrer(E1, E2 : in Element) return boolean;
--   FUNCTION Rechercher(E : IN Element; A : IN Arbre) RETURN Arbre IS
--      Res, ResG, ResD : Arbre;
--   BEGIN
--      Creer(Res); Creer(ResG); Creer(ResD);
--  --    Cpt1_Test := Cpt1_Test + 1;
--      Tab_Recherche(1) := TAb_Recherche(1)+1;
--      IF NOT Est_Vide(A) THEN
--  --       Cpt1_Test := Cpt1_Test + 1;
--         Tab_Recherche(1) := TAb_Recherche(1)+1;
--         IF Filtrer(Racine(A), E) THEN
--            Inserer(Racine(A), Res);
--         END IF;
--  --       Cpt1_Parc := Cpt1_Parc+1;
--         Tab_Recherche(2) := TAb_Recherche(2)+1;
--  --       Res.all.Gauche := Rechercher(E, Sous_Arbre_Gauche(A));
--         ResG := Rechercher(E, Sous_Arbre_Gauche(A));
--         Concatener(Res, ResG);
--  --       Cpt1_Parc := Cpt1_Parc+1;
--         Tab_Recherche(2) := TAb_Recherche(2)+1;
--  --       Res.all.Droite := Rechercher(E, Sous_Arbre_Droit(A));

--         ResD := Rechercher(E, Sous_Arbre_Droit(A));
--         Concatener(Res, ResD);
--      END IF;
--  --    Put_Line("GLOBAL --- test :"&Integer'Image(Cpt1_Test)&" ; parc : "&Integer'Image(Cpt1_Parc));
--      Put_Line("GLOBAL --- test :"&Integer'Image(Tab_Recherche(1))&" ; parc : "&Integer'Image(Tab_Recherche(2)));

--      RETURN Res;
--   END Rechercher;


--        -- Fonction permettant de rechercher dans la liste les elements verifiant
--        -- certaines proprietes (exprimees dans Filtrer) et avec des conditions
--        -- d'arrêt de la recherche
--  --      GENERIC
--  --         WITH FUNCTION Filtrer(E1, E2 : IN Element) RETURN Boolean;
--  --         WITH FUNCTION Direction_Filtrer(E1, E2 : IN Element) RETURN Boolean;
--  -- Cpt2_Test : Natural := 0;
--  -- cpt2_parc : natural := 0;

--   FUNCTION Rechercher_Ordre(E : IN Element; A : IN Arbre) RETURN Arbre IS
--      Res, ResG, ResD : Arbre;
--   BEGIN
--      Creer(Res); Creer(ResG); Creer(ResD);
--  --    Cpt2_Test := Cpt2_Test + 1;
--      Tab_Recherche_Ordre(1) := Tab_Recherche_Ordre(1)+1;
--      IF NOT Est_Vide(A) THEN
--  --       Cpt2_Test := Cpt2_Test + 1;
--         Tab_Recherche_Ordre(1) := Tab_Recherche_Ordre(1)+1;

--         IF Filtrer(Racine(A), E) THEN
--            Inserer(Racine(A), Res);
--  --         Cpt2_Parc := Cpt2_Parc+1;
--            Tab_Recherche_Ordre(2) := Tab_Recherche_Ordre(2)+1;

--            ResG := Rechercher_Ordre(E, Sous_Arbre_Gauche(A));
--            Concatener(Res, ResG);
--  --          Cpt2_Parc := Cpt2_Parc+1;
--            Tab_Recherche_Ordre(2) := Tab_Recherche_Ordre(2)+1;

--            ResD := Rechercher_Ordre(E, Sous_Arbre_Droit(A));
--            Concatener(Res, ResD);
--         ELSE
--  --          Cpt2_Test := Cpt2_Test + 1;
--            Tab_Recherche_Ordre(1) := Tab_Recherche_Ordre(1)+1;

--            IF Direction_Filtrer(Racine(A), E) THEN
--  --             Cpt2_Parc := Cpt2_Parc+1;
--               Tab_Recherche_Ordre(2) := Tab_Recherche_Ordre(2)+1;

--               ResG := Rechercher_Ordre(E, Sous_Arbre_Gauche(A));
--               Concatener(Res, ResG);
--            ELSE
--  --             Cpt2_Parc := Cpt2_Parc+1;
--               Tab_Recherche_Ordre(2) := Tab_Recherche_Ordre(2)+1;

--               ResD := Rechercher_Ordre(E, Sous_Arbre_Droit(A));
--               Concatener(Res, ResD);
--            END IF;
--         END IF;
--      END IF;
--  --    Put_Line("GLOBAL --- test :"&Integer'Image(Cpt2_Test)&" ; parc : "&Integer'Image(Cpt2_Parc));
--      Put_Line("GLOBAL --- test :"&Integer'Image(Tab_Recherche_Ordre(1))&" ; parc : "&Integer'Image(Tab_Recherche_Ordre(2)));

--      return Res;
--   END Rechercher_Ordre;


   --  PROCEDURE Impression_Couchee(A : IN Arbre; Decalage : IN String:= "") IS
   --  begin
   --     if A /= null then
   --        Impression_Couchee(A.All.Droite, Decalage&"  ");
   --        Put(Decalage);
   --        Put(Element_To_String(A.All.Info));
   --        New_Line;
   --        Impression_Couchee(A.All.Gauche, Decalage&"  ");
   --     end if;
   --  end Impression_Couchee;

END Arbre_Binaire_Recherche_G;



