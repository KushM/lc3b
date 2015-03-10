library verilog;
use verilog.vl_types.all;
entity cc is
    port(
        nzp             : in     vl_logic_vector(2 downto 0);
        nzpE            : in     vl_logic;
        N               : out    vl_logic;
        Z               : out    vl_logic;
        P               : out    vl_logic
    );
end cc;
