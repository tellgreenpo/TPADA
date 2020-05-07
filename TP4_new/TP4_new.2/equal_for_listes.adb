with Contacts;
use Contacts;
function Equal_For_Listes(C1,C2:Un_contact) return Boolean is
begin 
   return Telephone(C1) = Telephone(C2);
end Equal_For_Listes;
