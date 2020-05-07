with Abrs_Contacts,Lecture;
use Abrs_Contacts;
procedure Tester_Abrs_Contacts is
A : Abr;   
begin
   Init_Abr(A);
   Lecture("2015-02-16_11-35-09_Annuaire_100.txt",A);
   Put90(A);
end Tester_Abrs_Contacts;
