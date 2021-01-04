# typed: strict
# frozen_string_literal: true

require "ast_constants"
require "rubocop-ast"

module Utils
  # Helper functions for editing Ruby files.
  #
  # @api private
  module AST
    extend T::Sig

    Node = RuboCop::AST::Node
    SendNode = RuboCop::AST::SendNode
    BlockNode = RuboCop::AST::BlockNode
    ProcessedSource = RuboCop::AST::ProcessedSource
    TreeRewriter = Parser::Source::TreeRewriter

    module_function

<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      sig { params(body_node: Node).returns(T::Array[Node]) }
=======
>>>>>>> bottle: check actual bottle block contents when `--keep-old`
=======
      sig { params(body_node: Node).returns(T::Array[Node]) }
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> 05802623afd33b181473761d30b180f338e6278f
=======
      sig { params(body_node: Node).returns(T::Array[Node]) }
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> brew vendor-gems: commit updates.
      def body_children(body_node)
        if body_node.nil?
          []
        elsif body_node.begin_type?
          body_node.children.compact
        else
          [body_node]
        end
=======
>>>>>>> 6e9393c04700f224399e5a30fb5a9b6dc7e704e3
    sig { params(body_node: Node).returns(T::Array[Node]) }
    def body_children(body_node)
      if body_node.blank?
        []
      elsif body_node.begin_type?
        body_node.children.compact
      else
        [body_node]
<<<<<<< HEAD
      end
    end

=======
>>>>>>> c72b375a578ea53dabcc8cbbb2dc4363c2f81324
      end
    end

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      sig { params(formula_contents: String).returns(T.nilable(Node)) }
=======
<<<<<<< HEAD
>>>>>>> bottle: check actual bottle block contents when `--keep-old`
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> 05802623afd33b181473761d30b180f338e6278f
=======
      sig { params(formula_contents: String).returns(T.nilable(Node)) }
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> brew vendor-gems: commit updates.
      def bottle_block(formula_contents)
        formula_stanza(formula_contents, :bottle, type: :block_call)
=======
>>>>>>> 6e9393c04700f224399e5a30fb5a9b6dc7e704e3
    sig { params(name: Symbol, value: T.any(Numeric, String, Symbol), indent: T.nilable(Integer)).returns(String) }
    def stanza_text(name, value, indent: nil)
      text = if value.is_a?(String)
        _, node = process_source(value)
        value if (node.is_a?(SendNode) || node.is_a?(BlockNode)) && node.method_name == name
<<<<<<< HEAD
=======
>>>>>>> c72b375a578ea53dabcc8cbbb2dc4363c2f81324
>>>>>>> 6e9393c04700f224399e5a30fb5a9b6dc7e704e3
      end
      text ||= "#{name} #{value.inspect}"
      text = text.indent(indent) if indent && !text.match?(/\A\n* +/)
      text
    end

<<<<<<< HEAD
    sig { params(source: String).returns([ProcessedSource, Node]) }
    def process_source(source)
      ruby_version = Version.new(HOMEBREW_REQUIRED_RUBY_VERSION).major_minor.to_f
      processed_source = ProcessedSource.new(source, ruby_version)
      root_node = processed_source.ast
      [processed_source, root_node]
    end

    sig do
      params(
        component_name: Symbol,
        component_type: Symbol,
        target_name:    Symbol,
        target_type:    T.nilable(Symbol),
      ).returns(T::Boolean)
    end
    def component_match?(component_name:, component_type:, target_name:, target_type: nil)
      component_name == target_name && (target_type.nil? || component_type == target_type)
    end

    sig { params(node: Node, name: Symbol, type: T.nilable(Symbol)).returns(T::Boolean) }
    def call_node_match?(node, name:, type: nil)
      node_type = case node
      when SendNode then :method_call
      when BlockNode then :block_call
      else return false
      end

      component_match?(component_name: node.method_name,
                       component_type: node_type,
                       target_name:    name,
                       target_type:    type)
    end

    # Helper class for editing formulae.
    #
    # @api private
    class FormulaAST
      extend T::Sig
      extend Forwardable
      include AST

      delegate process: :tree_rewriter

      sig { params(formula_contents: String).void }
      def initialize(formula_contents)
        @formula_contents = formula_contents
        processed_source, children = process_formula
        @processed_source = T.let(processed_source, ProcessedSource)
        @children = T.let(children, T::Array[Node])
        @tree_rewriter = T.let(TreeRewriter.new(processed_source.buffer), TreeRewriter)
      end

      sig { returns(T.nilable(Node)) }
      def bottle_block
        stanza(:bottle, type: :block_call)
      end

<<<<<<< HEAD
      sig { params(name: Symbol, type: T.nilable(Symbol)).returns(T.nilable(Node)) }
      def stanza(name, type: nil)
        children.find { |child| call_node_match?(child, name: name, type: type) }
      end

<<<<<<< HEAD
      sig { params(bottle_output: String).void }
      def replace_bottle_block(bottle_output)
        replace_stanza(:bottle, bottle_output.chomp, type: :block_call)
      end

      sig { params(bottle_output: String).void }
      def add_bottle_block(bottle_output)
        add_stanza(:bottle, "\n#{bottle_output.chomp}", type: :block_call)
      end

=======
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      sig { params(formula_contents: String, name: Symbol, type: T.nilable(Symbol)).returns(T.nilable(Node)) }
=======
<<<<<<< HEAD
>>>>>>> bottle: check actual bottle block contents when `--keep-old`
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> 05802623afd33b181473761d30b180f338e6278f
=======
      sig { params(formula_contents: String, name: Symbol, type: T.nilable(Symbol)).returns(T.nilable(Node)) }
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> brew vendor-gems: commit updates.
=======
      def body_children(body_node)
        if body_node.nil?
          []
        elsif body_node.begin_type?
          body_node.children.compact
        else
          [body_node]
        end
      end

      def bottle_block(formula_contents)
        formula_stanza(formula_contents, :bottle, type: :block_call)
      end

>>>>>>> bottle: check actual bottle block contents when `--keep-old`
      def formula_stanza(formula_contents, name, type: nil)
        _, children = process_formula(formula_contents)
        children.find { |child| call_node_match?(child, name: name, type: type) }
      end

<<<<<<< HEAD
<<<<<<< HEAD
      sig { params(formula_contents: String, bottle_output: String).void }
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
      def replace_bottle_stanza!(formula_contents, bottle_output)
        replace_formula_stanza!(formula_contents, :bottle, bottle_output.chomp, type: :block_call)
      end

<<<<<<< HEAD
      sig { params(formula_contents: String, bottle_output: String).void }
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> bottle: check actual bottle block contents when `--keep-old`
      def replace_bottle_stanza!(formula_contents, bottle_output)
        replace_formula_stanza!(formula_contents, :bottle, bottle_output.chomp, type: :block_call)
      end

>>>>>>> utils/ast: cleanup
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> 05802623afd33b181473761d30b180f338e6278f
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> brew vendor-gems: commit updates.
=======
=======
>>>>>>> bottle: check actual bottle block contents when `--keep-old`
      def replace_bottle_stanza!(formula_contents, bottle_output)
        replace_formula_stanza!(formula_contents, :bottle, bottle_output.chomp, type: :block_call)
      end

>>>>>>> utils/ast: cleanup
      def add_bottle_stanza!(formula_contents, bottle_output)
        add_formula_stanza!(formula_contents, :bottle, "\n#{bottle_output.chomp}", type: :block_call)
      end

<<<<<<< HEAD
<<<<<<< HEAD
      sig do
        params(
          formula_contents: String,
          name:             Symbol,
          replacement:      T.any(Numeric, String, Symbol),
          type:             T.nilable(Symbol),
        ).void
      end
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
      def replace_formula_stanza!(formula_contents, name, replacement, type: nil)
        processed_source, children = process_formula(formula_contents)
=======
      def replace_formula_stanza!(formula_contents, name, replacement, type: nil)
<<<<<<< HEAD
=======
      def replace_formula_stanza!(formula_contents, name, replacement, type: nil)
<<<<<<< HEAD
>>>>>>> utils/ast: cleanup
        processed_source, body_node = process_formula(formula_contents)
        children = body_node.begin_type? ? body_node.children.compact : [body_node]
>>>>>>> utils/ast: cleanup
=======
        processed_source, children = process_formula(formula_contents)
>>>>>>> bottle: check actual bottle block contents when `--keep-old`
=======
        processed_source, children = process_formula(formula_contents)
>>>>>>> bottle: check actual bottle block contents when `--keep-old`
        stanza_node = children.find { |child| call_node_match?(child, name: name, type: type) }
        raise "Could not find #{name} stanza!" if stanza_node.nil?

        tree_rewriter = Parser::Source::TreeRewriter.new(processed_source.buffer)
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        tree_rewriter.replace(stanza_node.source_range, stanza_text(name, replacement, indent: 2).lstrip)
        formula_contents.replace(tree_rewriter.process)
      end

<<<<<<< HEAD
      sig do
        params(
          formula_contents: String,
          name:             Symbol,
          value:            T.any(Numeric, String, Symbol),
          type:             T.nilable(Symbol),
        ).void
      end
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
      def add_formula_stanza!(formula_contents, name, value, type: nil)
        processed_source, children = process_formula(formula_contents)
=======
        tree_rewriter.replace(stanza_node.source_range, replacement)
        formula_contents.replace(tree_rewriter.process)
      end

      def add_formula_stanza!(formula_contents, name, text, type: nil)
<<<<<<< HEAD
<<<<<<< HEAD
=======
        tree_rewriter.replace(stanza_node.source_range, replacement)
        formula_contents.replace(tree_rewriter.process)
      end

      def add_formula_stanza!(formula_contents, name, text, type: nil)
>>>>>>> utils/ast: cleanup
        processed_source, body_node = process_formula(formula_contents)
>>>>>>> utils/ast: cleanup
=======
=======
        tree_rewriter.replace(stanza_node.source_range, stanza_text(name, replacement, indent: 2).lstrip)
        formula_contents.replace(tree_rewriter.process)
      end

      def add_formula_stanza!(formula_contents, name, value, type: nil)
>>>>>>> utils/ast: add `stanza_text` helper function
=======
        tree_rewriter.replace(stanza_node.source_range, stanza_text(name, replacement, indent: 2).lstrip)
        formula_contents.replace(tree_rewriter.process)
      end

      def add_formula_stanza!(formula_contents, name, value, type: nil)
>>>>>>> utils/ast: add `stanza_text` helper function
        processed_source, children = process_formula(formula_contents)
>>>>>>> bottle: check actual bottle block contents when `--keep-old`
=======
    sig { params(source: String).returns([ProcessedSource, Node]) }
    def process_source(source)
      ruby_version = Version.new(HOMEBREW_REQUIRED_RUBY_VERSION).major_minor.to_f
      processed_source = ProcessedSource.new(source, ruby_version)
      root_node = processed_source.ast
      [processed_source, root_node]
    end

    sig do
      params(
        component_name: Symbol,
        component_type: Symbol,
        target_name:    Symbol,
        target_type:    T.nilable(Symbol),
      ).returns(T::Boolean)
    end
    def component_match?(component_name:, component_type:, target_name:, target_type: nil)
      component_name == target_name && (target_type.nil? || component_type == target_type)
    end

    sig { params(node: Node, name: Symbol, type: T.nilable(Symbol)).returns(T::Boolean) }
    def call_node_match?(node, name:, type: nil)
      node_type = case node
      when SendNode then :method_call
      when BlockNode then :block_call
      else return false
      end

      component_match?(component_name: node.method_name,
                       component_type: node_type,
                       target_name:    name,
                       target_type:    type)
    end

    # Helper class for editing formulae.
    #
    # @api private
    class FormulaAST
      extend T::Sig
      extend Forwardable
      include AST

      delegate process: :tree_rewriter

      sig { params(formula_contents: String).void }
      def initialize(formula_contents)
        @formula_contents = formula_contents
        processed_source, children = process_formula
        @processed_source = T.let(processed_source, ProcessedSource)
        @children = T.let(children, T::Array[Node])
        @tree_rewriter = T.let(TreeRewriter.new(processed_source.buffer), TreeRewriter)
      end

      sig { returns(T.nilable(Node)) }
      def bottle_block
        stanza(:bottle, type: :block_call)
      end

      sig { params(name: Symbol, type: T.nilable(Symbol)).returns(T.nilable(Node)) }
      def stanza(name, type: nil)
        children.find { |child| call_node_match?(child, name: name, type: type) }
      end

      sig { params(bottle_output: String).void }
      def replace_bottle_block(bottle_output)
        replace_stanza(:bottle, bottle_output.chomp, type: :block_call)
      end

      sig { params(bottle_output: String).void }
      def add_bottle_block(bottle_output)
        add_stanza(:bottle, "\n#{bottle_output.chomp}", type: :block_call)
      end
>>>>>>> c72b375a578ea53dabcc8cbbb2dc4363c2f81324

>>>>>>> 6e9393c04700f224399e5a30fb5a9b6dc7e704e3
      sig { params(name: Symbol, replacement: T.any(Numeric, String, Symbol), type: T.nilable(Symbol)).void }
      def replace_stanza(name, replacement, type: nil)
        stanza_node = stanza(name, type: type)
        raise "Could not find `#{name}` stanza!" if stanza_node.blank?

        tree_rewriter.replace(stanza_node.source_range, stanza_text(name, replacement, indent: 2).lstrip)
      end

      sig { params(name: Symbol, value: T.any(Numeric, String, Symbol), type: T.nilable(Symbol)).void }
      def add_stanza(name, value, type: nil)
=======
        processed_source, children = process_formula(formula_contents)

>>>>>>> bottle: check actual bottle block contents when `--keep-old`
        preceding_component = if children.length > 1
          children.reduce do |previous_child, current_child|
            if formula_component_before_target?(current_child,
                                                target_name: name,
                                                target_type: type)
              next current_child
            else
              break previous_child
            end
          end
        else
          children.first
        end
        preceding_component = preceding_component.last_argument if preceding_component.is_a?(SendNode)

        preceding_expr = preceding_component.location.expression
        processed_source.comments.each do |comment|
          comment_expr = comment.location.expression
          distance = comment_expr.first_line - preceding_expr.first_line
          case distance
          when 0
            if comment_expr.last_line > preceding_expr.last_line ||
               comment_expr.end_pos > preceding_expr.end_pos
              preceding_expr = comment_expr
            end
          when 1
            preceding_expr = comment_expr
          end
        end

<<<<<<< HEAD
        tree_rewriter.insert_after(preceding_expr, "\n#{stanza_text(name, value, indent: 2)}")
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
        tree_rewriter = Parser::Source::TreeRewriter.new(processed_source.buffer)
        tree_rewriter.insert_after(preceding_expr, "\n#{stanza_text(name, value, indent: 2)}")
>>>>>>> utils/ast: add `stanza_text` helper function
        formula_contents.replace(tree_rewriter.process)
      end

      sig { params(name: Symbol, value: T.any(Numeric, String, Symbol), indent: T.nilable(Integer)).returns(String) }
      def stanza_text(name, value, indent: nil)
        text = if value.is_a?(String)
          _, node = process_source(value)
<<<<<<< HEAD
<<<<<<< HEAD
          value if (node.is_a?(SendNode) || node.is_a?(BlockNode)) && node.method_name == name
=======
          value if (node.send_type? || node.block_type?) && node.method_name == name
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> utils/ast: add `stanza_text` helper function
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> 05802623afd33b181473761d30b180f338e6278f
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> brew vendor-gems: commit updates.
=======
          value if (node.send_type? || node.block_type?) && node.method_name == name
>>>>>>> utils/ast: add `stanza_text` helper function
        end
        text ||= "#{name} #{value.inspect}"
        text = text.indent(indent) if indent && !text.match?(/\A\n* +/)
        text
<<<<<<< HEAD
=======
>>>>>>> c72b375a578ea53dabcc8cbbb2dc4363c2f81324
>>>>>>> 6e9393c04700f224399e5a30fb5a9b6dc7e704e3
      end
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
      end
>>>>>>> utils/ast: add `stanza_text` helper function

      private
=======
=======
>>>>>>> 05802623afd33b181473761d30b180f338e6278f

<<<<<<< HEAD
      private
=======
=======
>>>>>>> brew vendor-gems: commit updates.

      private
=======

      private

=======
>>>>>>> utils/ast: add `stanza_text` helper function
      def process_source(source)
        Homebrew.install_bundler_gems!
        require "rubocop-ast"
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b

<<<<<<< HEAD
      def process_source(source)
        Homebrew.install_bundler_gems!
        require "rubocop-ast"
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b

      def process_source(source)
        Homebrew.install_bundler_gems!
        require "rubocop-ast"
>>>>>>> utils/ast: add `stanza_text` helper function

<<<<<<< HEAD
      sig { returns(String) }
      attr_reader :formula_contents

      sig { returns(ProcessedSource) }
      attr_reader :processed_source

      sig { returns(T::Array[Node]) }
      attr_reader :children

      sig { returns(TreeRewriter) }
      attr_reader :tree_rewriter

      sig { returns([ProcessedSource, T::Array[Node]]) }
      def process_formula
=======
      sig { params(source: String).returns([ProcessedSource, Node]) }
      def process_source(source)
        ruby_version = Version.new(HOMEBREW_REQUIRED_RUBY_VERSION).major_minor.to_f
<<<<<<< HEAD
<<<<<<< HEAD
        processed_source = ProcessedSource.new(source, ruby_version)
        root_node = processed_source.ast
        [processed_source, root_node]
      end
=======
=======
>>>>>>> utils/ast: add `stanza_text` helper function
        processed_source = RuboCop::AST::ProcessedSource.new(source, ruby_version)
        root_node = processed_source.ast
        [processed_source, root_node]
      end
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======

      def process_formula(formula_contents)
        processed_source, root_node = process_source(formula_contents)
>>>>>>> utils/ast: add `stanza_text` helper function

      def process_formula(formula_contents)
>>>>>>> 6e9393c04700f224399e5a30fb5a9b6dc7e704e3
        processed_source, root_node = process_source(formula_contents)
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> brew vendor-gems: commit updates.

      def process_formula(formula_contents)
        processed_source, root_node = process_source(formula_contents)
<<<<<<< HEAD
>>>>>>> utils/ast: add `stanza_text` helper function
=======
>>>>>>> 815859806c7c29663d178722358e79c2b2ae597b
>>>>>>> 05802623afd33b181473761d30b180f338e6278f
=======
      sig { returns(String) }
      attr_reader :formula_contents

      sig { returns(ProcessedSource) }
      attr_reader :processed_source
>>>>>>> c72b375a578ea53dabcc8cbbb2dc4363c2f81324

      sig { returns(T::Array[Node]) }
      attr_reader :children

      sig { returns(TreeRewriter) }
      attr_reader :tree_rewriter

      sig { returns([ProcessedSource, T::Array[Node]]) }
      def process_formula
        processed_source, root_node = process_source(formula_contents)

        class_node = root_node if root_node.class_type?
        if root_node.begin_type?
          nodes = root_node.children.select(&:class_type?)
          class_node = if nodes.count > 1
            nodes.find { |n| n.parent_class&.const_name == "Formula" }
          else
            nodes.first
          end
        end

        raise "Could not find formula class!" if class_node.nil?

        children = body_children(class_node.body)
        raise "Formula class is empty!" if children.empty?

        [processed_source, children]
      end

      sig { params(node: Node, target_name: Symbol, target_type: T.nilable(Symbol)).returns(T::Boolean) }
      def formula_component_before_target?(node, target_name:, target_type: nil)
        FORMULA_COMPONENT_PRECEDENCE_LIST.each do |components|
          return false if components.any? do |component|
            component_match?(component_name: component[:name],
                             component_type: component[:type],
                             target_name:    target_name,
                             target_type:    target_type)
          end
          return true if components.any? do |component|
            call_node_match?(node, name: component[:name], type: component[:type])
          end
        end

        false
      end
    end
  end
end
