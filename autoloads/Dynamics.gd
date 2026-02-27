extends Node

const dynamics_solver_script = preload("res://utils/dynamics_solver.gd")
const dynamics_solver_vector_script = preload("res://utils/dynamics_solver_vector.gd")

func create_dynamics(f: float, z: float, r: float) -> DynamicsSolver:
	var solver = Node.new()
	solver.set_script(dynamics_solver_script)
	solver.f = f
	solver.z = z
	solver.r = r
	get_tree().root.call_deferred("add_child", solver)
	return solver

func create_dynamics_vector(f: float, z: float, r: float) -> DynamicsSolverVector:
	var solver = Node.new()
	solver.set_script(dynamics_solver_vector_script)
	solver.f = f
	solver.z = z
	solver.r = r
	get_tree().root.call_deferred("add_child", solver)
	return solver
