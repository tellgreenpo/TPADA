with Listes_Ordonnees_G,Contacts,Inf_contact,Equal_For_listes;
use Contacts;

package Listes_Ordonnees_Contacts is new Listes_Ordonnees_G(Element => Un_Contact,
							    "<" => Inf_contact,
							    "=" => equal_For_listes,
							    Element_To_String => Contact_To_String,
							    Liberer_Element => Liberer_Contact);
