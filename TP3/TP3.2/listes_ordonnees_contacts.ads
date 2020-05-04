with Listes_Ordonnees_G,Pointeurs_De_Strings,contacts;
use Pointeurs_De_Strings,contacts;

package Listes_Ordonnees_Contacts is new Listes_Ordonnees_G(Element => Un_Contact,
							    "<"=>Contacts."<",
							    "="=>Contacts."=",
							    Element_To_String => Contact_To_String,
							    Liberer_Element => Liberer_contact);

