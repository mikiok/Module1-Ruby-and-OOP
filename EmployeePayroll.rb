class Employee
    attr_reader :name, :email
    def initialize(name, email)
      @name = name
      @email = email
    end
end

class HourlyEmployee < Employee
    def initialize(name, email, hourly_rate, hours_worked)
        super(name, email)
        @hourly_rate = hourly_rate
        @hours_worked = hours_worked
    end

    def calculate_salary
      	@hours_worked*@hourly_rate
    end
end

class SalariedEmployee < Employee
    def initialize(name, email, yearly_salary)
        super(name, email)
        @yearly_salary = yearly_salary
    end

    def calculate_salary
      	@yearly_salary/52
    end
end

class MultiPaymentEmployee < Employee
    def initialize(name, email, yearly_salary, hourly_rate, hours_worked)
        super(name, email)
        @yearly_salary = yearly_salary
        @hourly_rate = hourly_rate
        @hours_worked = hours_worked
    end

    def calculate_salary
      	@yearly_salary/52 + (@hours_worked - 40)*@hourly_rate
    end
end

class Payroll
    def initialize(employees)
      	@employees = employees
 	end
  	def pay_employees
      	@employees.each do |employee|
      		notify_employee(employee)
      		taxed_salary = employee.calculate_salary - tax_rate(employee.calculate_salary)
      		puts "#{employee.name}: $#{taxed_salary} this week"
      	end
  	end
  	private
  	def tax_rate(salary)
  		tax = (salary*18)/100
  	end
  	def notify_employee(employee)
  		puts "#{employee.name} we paid you. Check your email: #{employee.email}"
  	end


end


josh = HourlyEmployee.new("Josh", "nachoemail@example.com", 35, 50)
nizar = SalariedEmployee.new("Nizar", "starcraftrulez@gmail.com", 1000000)
ted = MultiPaymentEmployee.new("Ted", "fortranr0x@gmail.com", 60000, 275, 55)
me = HourlyEmployee.new("Miguel", "msanchezbrunetealvarez@gmail.com", 20, 40)
guli = SalariedEmployee.new("Ignacio", "guli@gmail.com", 60000)

employees = [josh, nizar, ted, me, guli]
payroll = Payroll.new(employees)
payroll.pay_employees