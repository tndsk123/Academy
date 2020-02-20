package userInfomation.dto;

public class UserInfomationDTO {
	private String id;
	private String passwd;
	private String name;
	private String nickname;
	private String email;
	private String hp;
	private String birth;
	private String address;
	private String join_date;
	private int accesscode;
	private int email_check;
	private String img;
	private int imgsize;
	public int getImgsize() {
		return imgsize;
	}
	public void setImgsize(int imgsize) {
		this.imgsize = imgsize;
	}
	public String getExt() {
		return ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
	private String ext;
	
	public int getEmail_check() {
		return email_check;
	}
	public void setEmail_check(int email_check) {
		this.email_check = email_check;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public int getAccesscode() {
		return accesscode;
	}
	public void setAccesscode(int accesscode) {
		this.accesscode = accesscode;
	}
	@Override
	public String toString() {
		return "UserInfomationDTO [id=" + id + ", passwd=" + passwd + ", name=" + name + ", nickname=" + nickname
				+ ", email=" + email + ", hp=" + hp + ", birth=" + birth + ", address=" + address + ", join_date="
				+ join_date + ", accesscode=" + accesscode + ", email_check=" + email_check + ", img=" + img
				+ ", imgsize=" + imgsize + ", ext=" + ext + "]";
	}
	public UserInfomationDTO() {
	}
	public UserInfomationDTO(String id, String passwd, String name, String nickname, String email, String hp,
			String birth, String address, String join_date, int accesscode, int email_check, String img, int imgsize) {
		super();
		this.id = id;
		this.passwd = passwd;
		this.name = name;
		this.nickname = nickname;
		this.email = email;
		this.hp = hp;
		this.birth = birth;
		this.address = address;
		this.join_date = join_date;
		this.accesscode = accesscode;
		this.email_check = email_check;
		this.img = img;
		this.imgsize = imgsize;
	}
	public UserInfomationDTO(String name, String email) {
		this.name = name;
		this.email = email;
	}
	public UserInfomationDTO(String id, String name, String email) {
		this.id = id;
		this.name = name;
		this.email = email;
	}
	
	
}
