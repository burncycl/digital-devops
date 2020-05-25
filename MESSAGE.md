### 2020/05 Michael Grate

## Message to the audience

TL;DR - I had fun.

First, I had fun writing this automation. It's been a while since I've had a chance to write Terraform, as my current employer doesn't use it. A few other things of note:
- This is an approach to automation. So, constructive criticism welcome, as I learn new tricks I incorporate into my approach and refactor old stuff.
- I haven't played with Terraform v0.12, as I left my previous company before addressing the accumulated v0.11 tech debt. Cool stuff! I like the simplier interpolations, richer conditionals, and validate and fmt commands. Btw, when I've ran into instances where Terraform conditional logic has fallen short (like interpolations in remote_state files or multi region deployments using Modules), I've used Jinj2 templates to achieve desired results.
- I have attempted some semblance of best practices, like using s3 remote state (with locking and replication) & roles. This considering the time to complete the assignment. For what it's worth, I am familar with concepts of least priviledge cloud security, and generally aim to use roles in a compartmentalized fashion.
- I am familar with Terraform Modules for reusability, although I don't have examples in this stack.
- I added some extra bells and whistles, as I manage my dev enviroment using Ansible automation, which I've included to show how I approach development holistically (i.e. Automate **EVERYTHING**).
- I have no prior experience with EKS. However, I have setup a lab at my house to practice k8s (it's cheaper than AWS). I'm really interested in getting more experience with EKS/k8s at the enterprise level. Hopefully this demonstrates the speed at which I absorb new technologies, and my excitement to learn them. I also hope my lack of experience doesn't scare you off. I think I'd pick things up rather quickly.
- I put an emphasis on documentation and sighting my sources. I also appreciate well written and useful documentation.
- I aim to write consistent code. Especially for stuff I wrote from scratch and didn't borrow. Hopefully that shows.

One thing to note, I use Makefiles throughout these modules. The reason for this is:
- Makefiles can bubble up exit codes from sub calls better than traditional shell scripts. Especially useful for CI/CD pipelines were you want failure to show up in the pipeline and not be supressed.
- Provides a way to control things like environment (e.g. dev, qa/staging, prod) based on evaluating conditionals. Although, I don't have specific examples in this particular automation. I have used evaulations of the branch name to determine environment, as I've implemented GitFlow in the past.
- Allows a sanity check for dependencies (e.g is Terraform, Kubectl, Helm, git, Packer, Ansible, etc. installed?). Fail fast and early if things are quite right.

