from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

env.io.hetatm = True
env.io.water = True

class MyModel(automodel):
    def select_atoms(self):
        return selection(self.residue_range('1:', '4:'),
                         self.residue_range('130:', '134:'),
                         self.residue_range('507:', '515:'),
                         self.residues['88'], self.residues['91'], self.residues['121'], self.residues['126'], self.residues['129'], self.residues['142'], self.residues['146'], self.residues['158'], self.residues['159'],
                         self.residues['234'], self.residues['236'], self.residues['237'], self.residues['239'], self.residues['316'], self.residues['421'], self.residues['450'], self.residues['469'], self.residues['470'],
                         self.residues['471'], self.residues['474'], self.residues['478'], self.residues['493'], self.residues['505'], self.residues['506'])
                         
    def special_restraints(self, aln):
        rsr = self.restraints
        at = self.atoms
        rsr.add(secondary_structure.alpha(self.residue_range('506:', '513:')))


a = MyModel(env, alnfile = 'alignment.ali',
              knowns = 'chainA_proteinintsolv', sequence = 'LeuT_fill')
a.starting_model= 1
a.ending_model  = 1

#a.md_level = None # No refinement of model

a.make()

