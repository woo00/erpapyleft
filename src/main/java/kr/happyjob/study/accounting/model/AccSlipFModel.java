package kr.happyjob.study.accounting.model;

import lombok.Getter;
import lombok.Setter;

@Getter 
@Setter
public class AccSlipFModel {
	/*   private String fnl_code;
	   private String est_odate;
	   private String est_no;
	   private String bacc_code;
	   private String bacc_name;
	   private String biz_iname;
	   private String biz_name;
	   private String detail_name;
	   private String dv_fee;*/
	




	
	public String getfnl_code() {
		return fnl_code;
	}
	public void setfnl_code(String fnl_code) {
		this.fnl_code = fnl_code;
	}

	
	public String getbacc_code() {
		return bacc_code;
	}
	public void setbacc_code(String bacc_code) {
		this.bacc_code = bacc_code;
	}
	
	public String getbacc_name() {
		return bacc_name;
	}
	public void setbacc_name(String bacc_name) {
		this.bacc_name = bacc_name;
	}
	

	public int getdv_ep() {
		return dv_ep;
	}
	public void setdv_ep(int dv_ep) {
		this.dv_ep = dv_ep;
	}
	
	public int getdv_fee() {
		return dv_fee;
	}
	public void setdv_fee(int dv_fee) {
		this.dv_fee = dv_fee;
	}
	
	  private String fnl_code;
	   private String bacc_code;
	   private String bacc_name;
	   private int dv_ep;
	   private int dv_fee;
	   
}
