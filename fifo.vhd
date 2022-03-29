library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fifo is
    Generic(
            aw : integer  := 2;
            dw : integer  := 2;
            l  : integer  := 4
            );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (dw-1 downto 0);
           wr_en : in STD_LOGIC;
           rd_en : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (dw-1 downto 0);
           full : out STD_LOGIC;
           empty : out STD_LOGIC;
           empty_n : out STD_LOGIC;
           full_n : out STD_LOGIC;
           err : out STD_LOGIC);
end fifo;

architecture sram of fifo is
    type mem_array is array (0 to l-1) of std_logic_vector(dw - 1 downto 0);
    
    signal mem : mem_array;
    signal rd_ptr, wr_ptr : std_logic_vector(aw-1 downto 0);
    signal ptr1, ptr2 : std_logic_vector(aw-1 downto 0);
    
    
begin
    p: process(clk, ptr1, rd_ptr, wr_ptr, wr_en, rd_en,rst)
    variable empty_i : std_ulogic := '1' ;
    variable full_i : std_ulogic := '0';
    variable em_nx  : std_ulogic := '0' ;
    variable full_nx : std_ulogic := '0';
    begin
        if rising_edge(clk) then
			if( rst = '1') then
				mem <= (others => (others => '0'));  
				rd_ptr <= (others => '0');
                wr_ptr <= (others => '0');
                ptr1 <= (others => '1');
                ptr2 <= (0 => '1' , others => '0');
                full_i := '0' ;
                full_nx := '0' ;
                empty_i := '1' ;
                em_nx := '0' ;			
				err <= '0';
		    else
			    if rd_ptr = wr_ptr then
                    if em_nx = '1' then
                        empty_i := '1';
                    elsif full_nx = '1' then
                        full_i := '1';
                    end if;
                else
                    empty_i := '0';
                    full_i := '0';
                end if;
                if ptr1 = rd_ptr then
                     em_nx := '1';
                else
                     em_nx := '0';
                end if;
                if ptr2 = rd_ptr then
                     full_nx := '1';
                else
                     full_nx := '0';
                end if;
			    if (wr_en = '1' and full_i = '0') then
			         mem(conv_integer(wr_ptr)) <= din;
			         err <= '0';
			         ptr1 <= ptr1 + '1';
			         ptr2 <= ptr2 + '1';
			         wr_ptr <= wr_ptr + '1';
			    elsif (wr_en = '1' and full_i = '1') then
			         err <= '1';
			    end if;
			    if rd_ptr = wr_ptr then
                    if em_nx = '1' then
                        empty_i := '1';
                    elsif full_nx = '1' then
                        full_i := '1';
                    end if;
                else
                    empty_i := '0';
                    full_i := '0';
                end if;
                if ptr1 = rd_ptr then
                     em_nx := '1';
                else
                     em_nx := '0';
                end if;
                if ptr2 = rd_ptr then
                     full_nx := '1';
                else
                     full_nx := '0';
                end if;
			            
                
			    if (rd_en = '1' and empty_i = '0') then
			         dout <= mem(conv_integer(rd_ptr));
			         err <= '0';
			         rd_ptr <= rd_ptr + '1';
			    elsif (rd_en = '1' and empty_i = '1') then
			         err <= '1';
			    end if;
			end if;
	    end if;
	full <= full_i;
	full_n <= full_nx;
	empty <= empty_i;
	empty_n <= em_nx;	
	end process ;                   
end sram;
