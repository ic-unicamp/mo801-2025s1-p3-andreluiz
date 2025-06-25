from migen import *

from litex.soc.interconnect.csr import *
from litex.gen import *

class Ising_model(LiteXModule):
    def __init__(self):
        self.input_lattice = CSRStorage(32)
        
        # Instância do módulo Verilog
        self.specials += Instance("Complete_peripheral",
            i_clk = ClockSignal(),
            i_reset = ResetSignal(),
            i_input_lattice=self.input_lattice.storage
        )
