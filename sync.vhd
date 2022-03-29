----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2022 12:21:00
-- Design Name: 
-- Module Name: sync - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sync is
    Port ( clk : in STD_LOGIC;
           rst: in STD_LOGIC;
           din : in STD_LOGIC;
           dout : out STD_LOGIC);
end sync;

architecture Behavioral of sync is
signal d0,d1,d2: std_logic;
signal c: std_logic_vector(1 downto 0);
begin
p1 : process(clk,rst)
begin
        if rst='1' then
        c <= "00";
        else
            if rising_edge(clk) then
                if c = "00" then
                    d0 <= din;
                    c <= "01";
                elsif c ="01" then
                    d1 <= d0;
                    c <= "10";
                elsif c = "10" then
                    d2 <= d1;
                    c <= "00";
                end if;
            end if;
        end if;
end process;   
dout <= d2;          


end Behavioral;
