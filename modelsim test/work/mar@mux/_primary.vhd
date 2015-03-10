library verilog;
use verilog.vl_types.all;
entity marMux is
    port(
        pcOut           : in     vl_logic_vector(15 downto 0);
        aluOut          : in     vl_logic_vector(15 downto 0);
        marmux          : in     vl_logic;
        marmuxOut       : out    vl_logic_vector(15 downto 0)
    );
end marMux;
