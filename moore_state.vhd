----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2024 11:52:24 AM
-- Design Name: 
-- Module Name: moore_state - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity moore_state is
  port (
       rst_i : in  std_logic;
       clk_i : in  std_logic;
       btnl_i : in  std_logic;
       btnc_i : in  std_logic;
       btnr_i : in  std_logic;
       del_o : out std_logic

 );

end moore_state;

architecture Behavioral of moore_state is



type State is (IDLE, STATE_1, STATE_2, STATE_3);
signal s : State;


begin

   

    process(clk_i,rst_i, btnl_i, btnc_i, btnr_i)
    begin
    
    
    
    if rst_i = '1' then 
      s <= IDLE;
      del_o <= '0'; 
      
    end if; 
        
        if rising_edge(clk_i) then
           case s is
               when IDLE =>
                del_o <= '0';
                   if btnl_i = '1' then
                       s <= STATE_1;
                   
                   else 
                    s <= IDLE;
                 

                    end if;

                when STATE_1 =>
                   if btnc_i = '1' and btnr_i = '1' then
                       s <= STATE_2;
                   
                   else s <= STATE_1; 

                   end if;


                when STATE_2 =>
                   if btnl_i = '1' then
                       s <= STATE_3;
                   
                   else s <= STATE_2; 

                    end if;

                when STATE_3 =>                   
                    if btnl_i = '1' then
                        del_o <= '1';
                    else 
                        
                        s <= IDLE;
                    
                    end if; 
                
               
                   

                   end case;
              end if;
        end process;


end Behavioral;
