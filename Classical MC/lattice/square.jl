mutable struct SquareLattice{D,S,L} <: SimpleLattice{D,S,L}
    unitcell::LatticeUtilities.UnitCell
    lattice::LatticeUtilities.Lattice
    bond::Dict
    function SquareLattice(unitcell,lattice::Lattice{D},bond) where D
        S = lattice.L
        return new{D,S,*(S...)}(unitcell,lattice,bond)
    end
end

function PeriSqua(L,W)
    square = UnitCell(lattice_vecs = [[0.,1.],[1.,0.]],basis_vecs = [[0.,0.]])
    lattice = Lattice(L = [W,L], periodic = [true,true])
    bond = Dict(
        (true,1) => vcat([[Bond((1,1), [i,0]),Bond((1,1), [0,i])] for i in [-1,1]]...),
        (false,1) => [Bond((1,1), [1,0]),Bond((1,1), [0,1])],
        (true,2) => [Bond((1,1), [i,j]) for i in [-1,1],j in [-1,1]][:],
        (false,2) => [Bond((1,1), [1,i]) for i in [-1,1]],
    )
    return SquareLattice(square,lattice,bond)
end
