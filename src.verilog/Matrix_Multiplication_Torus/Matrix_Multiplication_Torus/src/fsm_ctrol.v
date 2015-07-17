module FSM_Ctrol (
	input			RST,	//	Reset maestro
	input			CLK,	//	Reloj maestro
	input			STM,	//	Iniciar multiplicacion
	output reg		ENpH,	//	Habilitaciones Rp Alto 
	output reg		ENpL,	//	Habilitaciones Rp Bajo
	output reg		ENa,	//	Habilitaciones Ra
	output reg		ENr,	//	Habilitaciones Rr
	output reg		SEL,	//	Selector Mux 
	output reg		EOM		//	Fin de multiplicacion
	);	
	
	reg[2:0]	Qp,Qn;
	
	always @ *
	begin : Combinacional 
		case (Qp)
			3'b000 : begin	//	Idle
				if (STM)
					Qn = 3'b001;
				else
					Qn = Qp;
				ENpH = 1'b0;
				ENpL = 1'b0;
				ENa  = 1'b0;
				ENr  = 1'b0;	
				SEL  = 1'b0;
				EOM  = 1'b1;
			end
			3'b001 : begin
				Qn   = 3'b010;
				ENpH = 1'b1;
				ENpL = 1'b0;
				ENa  = 1'b0;
				ENr  = 1'b0;
				SEL  = 1'b0; 
				EOM  = 1'b0;
			end
			3'b010 : begin
				Qn   = 3'b011;
				ENpH = 1'b0;
				ENpL = 1'b1;
				ENa  = 1'b1;
				ENr  = 1'b0;	
				SEL  = 1'b0;
				EOM  = 1'b0;
			end	  
			3'b011 : begin
				Qn   = 3'b000;
				ENpH = 1'b0;
				ENpL = 1'b0;
				ENa  = 1'b1;
				ENr  = 1'b1;	
				SEL  = 1'b1; 
				EOM  = 1'b0;
			end	   
//			3'b100 : begin
//				Qn   = 3'b000;
//				ENpH = 1'b0;
//				ENpL = 1'b0;
//				ENa  = 1'b0;
//				ENr  = 1'b1;	
//				SEL  = 1'b0;
//			end
		endcase
	end
	
	always @ (posedge RST or posedge CLK)
	begin : Secuencial 
		if (RST)
			Qp <= 0;
		else
			Qp <= Qn;
	end
	
endmodule
