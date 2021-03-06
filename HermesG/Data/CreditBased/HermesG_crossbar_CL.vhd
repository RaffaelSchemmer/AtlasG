----------------------------------------------------------------
--                             CROSSBAR
--                           --------------
--              DATA_AV ->|                 |
--              DATA_IN ->|                 |
--             DATA_ACK <-|                 |-> TX
--               SENDER ->|                 |-> DATA_OUT
--                 FREE ->|                 |<- CREDIT_I
--               TAB_IN ->|                 |
--              TAB_OUT ->|                 |
--                          --------------
----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.HermesG_package.all;

entity HermesG_crossbar_CL is
port(
	data_av:     in  regNport;
	data_in:     in  arrayNport_regflit;
	data_ack:    out regNport;
	sender:      in  regNport;
	free:        in  regNport;
	tab_in:      in  arrayNport_reg3;
	tab_out:     in  arrayNport_reg3;
	tx:          out regNport;
	data_out:    out arrayNport_regflit;
	credit_i:    in  regNport);
end HermesG_crossbar_CL;

architecture AlgorithmXYG of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';

----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmXYG;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmWFNMG of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(EAST) when tab_in(SOUTH)="000" and data_av(SOUTH)='1' else
			credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmWFNMG;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmNLNMG of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH) when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH) when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else		
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else			
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmNLNMG;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmNFNMG of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else		
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else				
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else			
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(EAST) when tab_in(SOUTH)="000" and data_av(SOUTH)='1' else
			credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmNFNMG;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmWFMG of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(EAST) when tab_in(SOUTH)="000" and data_av(SOUTH)='1' else
			credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmWFMG;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmNLMG of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH) when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH) when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else		
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else			
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmNLMG;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmNFMG of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else		
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else				
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else			
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(EAST) when tab_in(SOUTH)="000" and data_av(SOUTH)='1' else
			credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmNFMG;

architecture AlgorithmXY of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';

----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmXY;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmWFNM of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(EAST) when tab_in(SOUTH)="000" and data_av(SOUTH)='1' else
			credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmWFNM;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmNLNM of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH) when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH) when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else		
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else			
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmNLNM;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmNFNM of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else		
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else				
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else			
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(EAST) when tab_in(SOUTH)="000" and data_av(SOUTH)='1' else
			credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmNFNM;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmWFM of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(EAST) when tab_in(SOUTH)="000" and data_av(SOUTH)='1' else
			credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmWFM;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmNLM of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH) when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH) when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else		
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else			
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else			
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmNLM;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
architecture AlgorithmNFM of HermesG_crossbar_CL is

begin
	tx(WEST) <= '0';
	data_out(WEST) <= (others=>'0');
	data_ack(WEST) <= '0';
----------------------------------------------------------------------------------
-- PORTA LOCAL
----------------------------------------------------------------------------------
	tx(LOCAL) <= data_av(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else		
			data_av(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_av(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			'0';

	data_out(LOCAL) <= data_in(EAST) when tab_out(LOCAL)="000" and free(LOCAL)='0' else			
			data_in(NORTH) when tab_out(LOCAL)="010" and free(LOCAL)='0' else
			data_in(SOUTH) when tab_out(LOCAL)="011" and free(LOCAL)='0' else
			(others=>'0');

	data_ack(LOCAL) <= credit_i(EAST) when tab_in(LOCAL)="000" and data_av(LOCAL)='1' else			
			credit_i(NORTH) when tab_in(LOCAL)="010" and data_av(LOCAL)='1' else
			credit_i(SOUTH) when tab_in(LOCAL)="011" and data_av(LOCAL)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA EAST
----------------------------------------------------------------------------------
	tx(EAST) <= data_av(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_av(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_av(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			'0';

	data_out(EAST) <= data_in(NORTH)  when tab_out(EAST)="010" and free(EAST)='0' else
			data_in(SOUTH) when tab_out(EAST)="011" and free(EAST)='0' else
			data_in(LOCAL) when tab_out(EAST)="100" and free(EAST)='0' else
			(others=>'0');

	data_ack(EAST) <= credit_i(NORTH) when tab_in(EAST)="010" and data_av(EAST)='1' else
			credit_i(SOUTH) when tab_in(EAST)="011" and data_av(EAST)='1' else
			credit_i(LOCAL) when tab_in(EAST)="100" and data_av(EAST)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA NORTH
----------------------------------------------------------------------------------
	tx(NORTH) <= data_av(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else				
			data_av(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_av(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			'0';

	data_out(NORTH) <= data_in(EAST) when tab_out(NORTH)="000" and free(NORTH)='0' else			
			data_in(SOUTH) when tab_out(NORTH)="011" and free(NORTH)='0' else
			data_in(LOCAL) when tab_out(NORTH)="100" and free(NORTH)='0' else
			(others=>'0');

	data_ack(NORTH) <= credit_i(EAST) when tab_in(NORTH)="000" and data_av(NORTH)='1' else			
			credit_i(SOUTH) when tab_in(NORTH)="011" and data_av(NORTH)='1' else
			credit_i(LOCAL) when tab_in(NORTH)="100" and data_av(NORTH)='1' else
			'0';
----------------------------------------------------------------------------------
-- PORTA SOUTH
----------------------------------------------------------------------------------
	tx(SOUTH) <= data_av(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_av(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_av(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			'0';

	data_out(SOUTH) <= data_in(EAST) when tab_out(SOUTH)="000" and free(SOUTH)='0' else
			data_in(NORTH) when tab_out(SOUTH)="010" and free(SOUTH)='0' else
			data_in(LOCAL) when tab_out(SOUTH)="100" and free(SOUTH)='0' else
			(others=>'0');

	data_ack(SOUTH) <= credit_i(EAST) when tab_in(SOUTH)="000" and data_av(SOUTH)='1' else
			credit_i(NORTH) when tab_in(SOUTH)="010" and data_av(SOUTH)='1' else
			credit_i(LOCAL) when tab_in(SOUTH)="100" and data_av(SOUTH)='1' else
			'0';

end AlgorithmNFM;
