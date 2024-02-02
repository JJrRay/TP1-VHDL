----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2024 03:22:13 PM
-- Design Name: 
-- Module Name: clignote_DEL - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clignote_DEL is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           sw_i : in STD_LOGIC;
           del_o : out STD_LOGIC);
end clignote_DEL;

architecture Behavioral of clignote_DEL is
--Inputs
  signal cntdiv_1   : std_logic_vector (24 downto 0);
  signal div_temp_1 : std_logic;
  signal cntdiv_2   : std_logic_vector (24 downto 0);
  signal div_temp_2 : std_logic;
begin

process (clk_i, rst_i)
 begin
 
    if rst_i = '1' then
      div_temp_1 <= '0';
      cntdiv_1   <= (others => '0');
    elsif rising_edge(clk_i) then
      -- Inverse la sortie après 2000/2 cycles d'horloge
      if unsigned(cntdiv_1) >= 15999999 then
        div_temp_1 <= not(div_temp_1);
        cntdiv_1   <= (others => '0');
      else
        div_temp_1 <= div_temp_1;
        cntdiv_1   <= std_logic_vector(unsigned(cntdiv_1) + 1);
      end if;
    end if;
  end process;
  
 process (clk_i, rst_i)
  begin  
  
    if rst_i = '1' then
          div_temp_2 <= '0';
          cntdiv_2   <= (others => '0');
        elsif rising_edge(clk_i) then
          -- Inverse la sortie après 2000/2 cycles d'horloge
          if unsigned(cntdiv_2) >= 3999999 then
            div_temp_2 <= not(div_temp_2);
            cntdiv_2   <= (others => '0');
          else
            div_temp_2 <= div_temp_2;
            cntdiv_2   <= std_logic_vector(unsigned(cntdiv_2) + 1);
          end if;
        end if;
     
   end process;
     
  process (sw_i,div_temp_1,div_temp_2)
   begin
  
  if sw_i = '0' then 
    del_o <= div_temp_1;
  else
    del_o <= div_temp_2;
   end if;

        
        
   
    end process;    
    end Behavioral;

-- les deux premier process c'est pour 2 signal avec periode differente 0.5s et 2s 
-- le 3 eme process cest pour selon l'entree sw_i il va choisir soit le signalavec 0.5 ou 2