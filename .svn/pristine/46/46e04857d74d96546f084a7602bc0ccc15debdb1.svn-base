package kr.happyjob.study.employee.model;


public class EmployeeGradeModel {
	
	//tb_userInfo table에서 가져오는 정보들
	private String loginID; //사용자 ID == 사원번호
	private String name; //사원명
	
	//tb_emp table에서 가져오는 정보들
	private String dep_code; //부서명
	private String POScd; //직급코드 -> 공통코드table
	
	private String prm_date; //발령일자 (승진이력 조회 시 필요)
	
	
	public String getLoginID() {
		return loginID;
	}


	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDep_code() {
		return dep_code;
	}


	public void setDep_code(String dep_code) {
		this.dep_code = dep_code;
	}


	public String getPOScd() {
		return POScd;
	}


	public void setPOScd(String pOScd) {
		POScd = pOScd;
	}


	public String getPrm_date() {
		return prm_date;
	}


	public void setPrm_date(String prm_date) {
		this.prm_date = prm_date;
	}


	@Override
	public String toString() {
		return "EmployeeGradeModel [loginID=" + loginID 
				+ ", name=" + name 
				+ ", dep_code=" + dep_code
				+ ", POScd=" + POScd + ", prm_date=" + prm_date 
				+ "]";
	}
}
