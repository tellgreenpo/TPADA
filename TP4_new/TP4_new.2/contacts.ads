with Pointeurs_De_Strings;
use  Pointeurs_De_Strings;

package Contacts is

   type Un_Contact is limited private;

   subtype Une_Cle is String(1..10);

   Erreur_Contact :  exception;

   --constructeur1
   procedure Initialiser_Contact(Nom, Prenom, Ville, Specialite, Telephone : in String; C : out Un_Contact);

   --constructeur 2
   procedure String_To_Contact(S : in String; C : out Un_Contact);
   --peut lever exception Erreur_Contact si S n'est pas correctement structure

   --Constructeur 3
   procedure Copy(C1 : in Un_Contact; C2 : out Un_Contact);

   --accesseurs
   function Nom(C : in Un_Contact) return String;
   function Prenom(C : in Un_Contact) return String;
   function Ville(C : in Un_Contact) return String;
   function Specialite(C : in Un_Contact) return String;
   function Telephone(C : in Un_Contact) return Une_Cle;

   --conversion en chaine
   function Contact_To_String(C : in Un_Contact) return String;

   --recuperation memoire
   procedure Liberer_Contact(C : in out Un_Contact);

private

   type Un_Contact is record
      Nom        : P_String;
      Prenom     : P_String;
      Ville      : P_String;
      Specialite : P_String;
      Telephone  : P_String;
   end record;

end Contacts;
