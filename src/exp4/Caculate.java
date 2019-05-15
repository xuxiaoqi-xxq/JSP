package exp4;

public class Caculate {

	private int first;

	private int second;

	private char op;

	public String getResult() {
		String result = "";
		if (op == '+') {
			result = "" + first + op + "" + second + "=" + String.valueOf((first + second));
		} else if (op == '-') {
			result = "" + first + op + "" + second + "=" + String.valueOf((first - second));
		} else if (op == '*') {
			result = "" + first + op + "" + second + "=" + String.valueOf((first * second));
		} else if(op == '/'){
			if (second == 0) {
				result = "除数不能为0";
			} else {
				result = "" + first + op + "" + second + "=" + String.valueOf((first / second));
			}
		}
		return result;
	}

	public int getFirst() {
		return first;
	}

	public void setFirst(int first) {
		this.first = first;
	}

	public int getSecond() {
		return second;
	}

	public void setSecond(int second) {
		this.second = second;
	}

	public char getOp() {
		return op;
	}

	public void setOp(char op) {
		this.op = op;
	}

}
