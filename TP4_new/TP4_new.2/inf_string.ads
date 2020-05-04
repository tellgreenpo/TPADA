   -- Ordre lexicographique strict entre 2 String de tailles quelconques,
   -- exemples : "a" < "abus" < "ada" < "additif" < "ado" < "bd"

function Inf_String(S1,S2 : in String) return Boolean;


-- *********************
-- exemple d'utilisation
-- *********************

--with Ada.Text_Io, Inf_Sting;
--use  Ada.Text_Io;

--procedure Test_String is
--begin
--   -- Put(Boolean'Image("ada" < "ado"));         --<<< ne compile pas (Ambiguous operands for comparison)

--   Put(Boolean'Image(Inf_String("ada","ado")));  --<<< OK !!

--end Test_String;
