----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2024 02:11:44 PM
-- Design Name: 
-- Module Name: moore_state_tb - Test
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

entity moore_state_tb is
--  Port ( );
end moore_state_tb;

architecture Test of moore_state_tb is
signal rst_i_tb, clk_i_tb, btnl_i_tb, btnc_i_tb, btnr_i_tb : std_logic := '0';
signal del_o_tb : std_logic;

 component moore_state
        port (
            rst_i : in  std_logic;
            clk_i : in  std_logic;
            btnl_i : in  std_logic;
            btnc_i : in  std_logic;
            btnr_i : in  std_logic;
            del_o : out std_logic
        );
    end component;
    
--Inputs
  signal rst_i                          : std_logic                    := '0';
  signal clk_i                          : std_logic                    := '0';
  signal btnl_i, btnc_i, btnr_i : std_logic                    := '0';
  
  
--Outputs
  signal del_o                          : std_logic                    :='0';
  
  
  --composante de test
  signal tb_done : boolean := false;
    

begin

uut: moore_state port map (
        rst_i => rst_i_tb,
        clk_i => clk_i_tb,
        btnl_i => btnl_i_tb,
        btnc_i => btnc_i_tb,
        btnr_i => btnr_i_tb,
        del_o => del_o_tb
    );

process
    begin
        clk_i_tb <= '0';
        wait for 5 ns;
        clk_i_tb <= '1';
        wait for 5 ns;
    end process;
    
    
process
    begin
        -- Reset initially
        
        rst_i <= '1';
        wait for 10 ns;
        rst_i <= '0';
        wait for 10 ns;
        

        -- Apply stimulus
        btnl_i_tb <= '0'; 
        btnc_i_tb <= '0';
        btnr_i_tb <= '0';
        wait for 5 ns; 
        
         -- Transition to STATE_1
        btnl_i_tb <= '1'; 
        btnc_i_tb <= '0';
        btnr_i_tb <= '0';
        wait for 25 ns;

        btnl_i_tb <= '0';
        btnc_i_tb <= '1';
        btnr_i_tb <= '1';  -- Transition to STATE_2
        wait for 10 ns;

        btnl_i_tb <= '1';  -- Transition to STATE_3
        btnc_i_tb <= '0';
        btnr_i_tb <= '0';
        wait for 50 ns; 
        
        btnl_i_tb <= '0';  
        btnc_i_tb <= '0';
        btnr_i_tb <= '0';
        
       

        wait ;

        tb_done <= true;
    end process;
    
process
    begin
        wait until tb_done;
        report "Simulation finished" severity note;
        wait;
    end process;

end Test;
