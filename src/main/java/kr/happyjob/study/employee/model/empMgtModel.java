package kr.happyjob.study.employee.model;

public class empMgtModel {
	

		public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

	public String getLeave_state() {
		return leave_state;
	}

	public void setLeave_state(String leave_state) {
		this.leave_state = leave_state;
	}

	public String getSecurity_num() {
		return security_num;
	}

	public void setSecurity_num(String security_num) {
		this.security_num = security_num;
	}

	public String getFile_code() {
		return file_code;
	}

	public void setFile_code(String file_code) {
		this.file_code = file_code;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGrade_code() {
		return grade_code;
	}

	public void setGrade_code(String grade_code) {
		this.grade_code = grade_code;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getDep_code() {
		return dep_code;
	}

	public void setDep_code(String dep_code) {
		this.dep_code = dep_code;
	}

	public String getStatus_yn() {
		return status_yn;
	}

	public void setStatus_yn(String status_yn) {
		this.status_yn = status_yn;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public String getLeave_date() {
		return leave_date;
	}

	public void setLeave_date(String leave_date) {
		this.leave_date = leave_date;
	}

		@Override
	public String toString() {
		return "empMgtModel [loginID=" + loginID + ", department=" + department + ", rank=" + rank + ", leave_state="
				+ leave_state + ", security_num=" + security_num + ", file_code=" + file_code + ", user_type="
				+ user_type + ", name=" + name + ", password=" + password + ", grade_code=" + grade_code + ", bank="
				+ bank + ", account=" + account + ", sex=" + sex + ", hp=" + hp + ", email=" + email + ", regdate="
				+ regdate + ", loc=" + loc + ", birthday=" + birthday + ", dep_code=" + dep_code + ", status_yn="
				+ status_yn + ", salary=" + salary + ", leave_date=" + leave_date + ", user_memo=" + user_memo + "]";
	}

		private String loginID;
		
		private String department;	// 부서명
		
		private String rank;					// 직급
		
		private String leave_state;
		
		private String leave_memo;

		public String getLeave_memo() {
			return leave_memo;
		}

		public void setLeave_memo(String leave_memo) {
			this.leave_memo = leave_memo;
		}

		private String security_num;
		
		private String file_code;
		
		private String bank_code;
		
		public String getBank_code() {
			return bank_code;
		}

		public void setBank_code(String bank_code) {
			this.bank_code = bank_code;
		}

		private String user_type;
		
		private String name;
		
		private String password;
		
		private String grade_code;
		
		private String  bank;
		
		private String account;
		
		private String sex;
		
		private String hp;
		
		private String email;
		
		private String regdate;
		
		private String loc;
		
		public String getPost() {
			return post;
		}

		public void setPost(String post) {
			this.post = post;
		}

		public String getLoc_detail() {
			return loc_detail;
		}

		public void setLoc_detail(String loc_detail) {
			this.loc_detail = loc_detail;
		}
		

		private String post;
		
		private String loc_detail;
		
		private String birthday;
		
		private String dep_code;
		
		private String status_yn;
		
		private int salary;
		
		private String leave_date;
		
		private String user_memo;

		public String getUser_memo() {
			return user_memo;
		}

		public void setUser_memo(String user_memo) {
			this.user_memo = user_memo;
		}
		
		// 파일처리
		
		
		private String abs_path;
		
		public String getAbs_path() {
			return abs_path;
		}

		public void setAbs_path(String abs_path) {
			this.abs_path = abs_path;
		}

		public String getRel_path() {
			return rel_path;
		}

		public void setRel_path(String rel_path) {
			this.rel_path = rel_path;
		}

		public String getFile_name() {
			return file_name;
		}

		public void setFile_name(String file_name) {
			this.file_name = file_name;
		}

		public int getSize() {
			return size;
		}

		public void setSize(int size) {
			this.size = size;
		}

		private String rel_path;
		
		private String file_name;
		
		private int size;

	
	
		
}	