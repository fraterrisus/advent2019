module Intcode
  class Interpreter
    Opcodes = {
      1 => :func_add,
      2 => :func_mul,
      99 => :func_halt,
    }.freeze

    def initialize(mem)
      @memory = mem.dup
      @iptr = 0
    end

    def run
      interpret
    end

    def memory_read(i)
      raise Intcode::MemoryOverflowException if i >= @memory.count
      @memory[i]
    end

    private

    def interpret
      while true
        # print "iptr: #{@iptr}"
        raise Intcode::MemoryOverflowException if @iptr >= @memory.count
        opcode = @memory[@iptr]
        function = Opcodes[opcode]
        # puts " function: #{function}"
        raise Intcode::UnrecognizedOpcodeException if function.nil?
        begin 
          send(function)
        rescue Intcode::StoppedException
          break
        end
      end
      puts 'Execution terminated normally.'
    end

    def iptr_advance(o)
      @iptr += o
    end

    def iptr_offset(o)
      memory_read(@iptr + o)
    end

    def memory_write(i,x)
      raise Intcode::MemoryOverflowException if i >= @memory.count
      @memory[i] = x
    end

    def func_add
      mem_a = iptr_offset 1
      mem_b = iptr_offset 2
      mem_c = iptr_offset 3
      a = memory_read(mem_a)
      b = memory_read(mem_b)
      c = a + b
      memory_write(mem_c, c)
      # puts "ADD [#{mem_a}],[#{mem_b}],[#{mem_c}] #{a}+#{b}=#{c}"
      iptr_advance 4
    end

    def func_mul
      mem_a = iptr_offset 1
      mem_b = iptr_offset 2
      mem_c = iptr_offset 3
      a = memory_read(mem_a)
      b = memory_read(mem_b)
      c = a * b
      memory_write(mem_c, c)
      # puts "MUL [#{mem_a}],[#{mem_b}],[#{mem_c}] #{a}*#{b}=#{c}"
      iptr_advance 4
    end

    def func_halt
      raise Intcode::StoppedException
    end
  end
end
