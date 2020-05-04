with Abrs_G,Contacts,Inf_String,equal;
use Contacts;
package Abrs_Contacts is new Abrs_G(Element => Contacts.Un_Contact,
				       Cle => Une_cle,
				       Cle_De => Contacts.Telephone,
				       "=" => equal,
				       "<" => Inf_String,
				       Liberer_Element => Liberer_Contact,
				       Element_To_String => Contact_To_String,
				       Copy => Contacts.Copy
				   );
