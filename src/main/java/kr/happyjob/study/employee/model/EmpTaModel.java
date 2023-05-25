package kr.happyjob.study.employee.model;

public class EmpTaModel {
	private String vcn_reason;	
	private String va_div;								
	private int va_code;							
	private String st_date;								
	private String sign_yn;								
	private String sign_user;								
	private String re_reason;								
	private String loginID;							
	private String em_hp;								
	private String ed_date;								
	private String app_date;
	 
	private String va_name; /* 휴가 종류  */
	private String name; /*사원명 */
	private String sign_username;/* 승인자*/
	private String sign_ynname; /* 승인여부*/
	 
	
	private String dept_name; /*근무부서*/
	
	
	
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getVa_div() {
		return va_div;
	}
	public void setVa_div(String va_div) {
		this.va_div = va_div;
	}
	public int getVa_code() {
		return va_code;
	}
	public void setVa_code(int va_code) {
		this.va_code = va_code;
	}
	public String getSt_date() {
		return st_date;
	}
	public void setSt_date(String st_date) {
		this.st_date = st_date;
	}
	public String getSign_yn() {
		return sign_yn;
	}
	public void setSign_yn(String sign_yn) {
		this.sign_yn = sign_yn;
	}
	public String getSign_user() {
		return sign_user;
	}
	public void setSign_user(String sign_user) {
		this.sign_user = sign_user;
	}
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getEm_hp() {
		return em_hp;
	}
	public void setEm_hp(String em_hp) {
		this.em_hp = em_hp;
	}
	public String getEd_date() {
		return ed_date;
	}
	public void setEd_date(String ed_date) {
		this.ed_date = ed_date;
	}
	public String getApp_date() {
		return app_date;
	}
	public void setApp_date(String app_date) {
		this.app_date = app_date;
	}
	public String getVa_name() {
		return va_name;
	}
	public void setVa_name(String va_name) {
		this.va_name = va_name;
	}
	public String getSign_username() {
		return sign_username;
	}
	public void setSign_username(String sign_username) {
		this.sign_username = sign_username;
	}
	public String getSign_ynname() {
		return sign_ynname;
	}
	public void setSign_ynname(String sign_ynname) {
		this.sign_ynname = sign_ynname;
	}
	public String getVcn_reason() {
		return vcn_reason;
	}
	public void setVcn_reason(String vcn_reason) {
		this.vcn_reason = vcn_reason;
	}
	public String getRe_reason() {
		return re_reason;
	}
	public void setRe_reason(String re_reason) {
		this.re_reason = re_reason;
	}
	
	
}
