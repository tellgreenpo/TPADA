with Pointeurs_De_Strings, Lire_Mot;

package body Contacts is

   procedure Initialiser_Contact(Nom, Prenom, Ville, Specialite, Telephone : in String; C : out Un_Contact) is
   begin
      C := (new String'(Nom), new String'(Prenom), new string'(Ville), new string'(Specialite), new string'(Telephone));
   end Initialiser_Contact;

   procedure String_To_Contact(S : in String; C : out Un_Contact) is
      DP,FP, DN,FN, DV,FV, DS,FS, DT,FT : Integer;
   begin
      -- ATTENTION DANS LES FICHIERS annuaire, LE PRENOM EST PLACE AVANT LE NOM
      -- lire le prenom d'abord
      Lire_Mot(S(S'first..S'last),DP,FP);
      -- lire le nom ensuite
      Lire_Mot(S(FP+1..S'last),  DN,FN);
      -- lire la ville
      Lire_Mot(S(FN+1..S'last),  DV,FV);
      -- lire la specialite
      Lire_Mot(S(FV+1..S'last),  DS,FS);
      -- lire le telephone
      Lire_Mot(S(FS+1..S'Last),  DT,FT);

      if DP>FP or DN>FN or DV>FV or DS>FS or DT>FT then
         raise Erreur_Contact;
      end if;

      Initialiser_Contact(S(DN..FN),
                          S(DP..FP),
                          S(DV..FV),
                          S(DS..FS),
                          S(DT..FT),
                          C);
   end String_To_Contact;

  procedure Copy(C1 : in Un_Contact; C2 : out Un_Contact) is
  begin
      C2 := (Nom       => new String'(C1.Nom.All),
             Prenom    => new String'(C1.Prenom.all),
             Ville     => new String'(C1.Ville.all),
             Specialite=> new String'(C1.Specialite.all),
             Telephone => new String'(C1.Telephone.All)
             );
   end Copy;

   function Nom(C : in Un_Contact) return String is
   begin
      return C.Nom.all;
   end Nom;

   function Prenom(C : in Un_Contact) return String is
   begin
      return C.Prenom.all;
   end Prenom;

   function Ville(C : in Un_Contact) return String is
   begin
      return C.Ville.all;
   end Ville;

   function Specialite(C : in Un_Contact) return String is
   begin
      return C.Specialite.all;
   end Specialite;

   function Telephone(C : in Un_Contact) return Une_Cle is
   begin
      return C.Telephone.all;
   end Telephone;

   function Contact_To_String(C : in Un_Contact) return String is
   begin
      return C.Nom.all & " " & C.Prenom.all & " " & C.Ville.all & " " & C.Specialite.all & " " & C.Telephone.all;
   end Contact_To_String;


   procedure Liberer_Contact(C : in out Un_Contact) is
   begin
      Liberer_String(C.Nom);
      Liberer_String(C.Prenom);
      Liberer_String(C.Ville);
      Liberer_String(C.Specialite);
      Liberer_String(C.Telephone);
   end Liberer_Contact;


end Contacts;
